#include "mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    
    this->scene = new CustomScene();
    
    this->GOL_image = QImage(num_cell_cols, num_cell_rows, QImage::Format_Mono);
    this->GOL_image.fill(0);

    this->ui->chunkColsSpinbox->setValue(this->num_chunk_cols);
    this->ui->chunkRowsSpinbox->setValue(this->num_chunk_rows);
    
    this->pm_item = this->scene->addPixmap(QPixmap::fromImage(this->GOL_image));
    
    this->ui->GOLgraphicsView->setScene(scene);
    //this->ui->GOLgraphicsView->fitInView(this->ui->GOLgraphicsView->rect());
    this->ui->GOLgraphicsView->show();
    
    //    quint32 data[NUM_WORDS] = {0};
    
    //    this->writeToImage(data, NUM_WORDS);
    //this->writeToImage((quint32[]){0xdeadbeef, 0xdec0de1c, 0xdeadbeef, 0xdec0de1c}, 4);
    
    connect(this->scene, &CustomScene::pixelClicked, this, &MainWindow::handlePixelClick);
    connect(this->scene, &CustomScene::mouseReleased, this, &MainWindow::handleMouseRelease);
    
    this->on_doubleSpinBox_valueChanged(this->ui->doubleSpinBox->value());
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::clearImage(){
    this->GOL_image.fill(0);
    this->pm_item->setPixmap(QPixmap::fromImage(this->GOL_image));
}

void MainWindow::saveState(){

    std::vector<std::vector<chunk_struct>> block;
    QPoint lowest_rightmost_live_chunk(0, 0);

    for (int chunk_y = 0; chunk_y < num_chunk_rows; ++chunk_y){
        std::vector<chunk_struct> chunk_row;
        block.push_back(chunk_row);
        for (int chunk_x = 0; chunk_x < num_chunk_cols; ++chunk_x){
            chunk_struct chunk;
            block[chunk_y].push_back(chunk);
            bool has_live_cells = false;
            for (int cell_y = 0; cell_y < CHUNK_HEIGHT; ++cell_y){
                for (int cell_x = 0; cell_x < CHUNK_WIDTH; ++cell_x){
                    int block_y = chunk_y*CHUNK_HEIGHT + cell_y;
                    int block_x = chunk_x*CHUNK_WIDTH + cell_x;
                    QRgb pixel = this->GOL_image.pixel(block_x, block_y);
                    bool bit = pixel & pixel_mask;
                    block[chunk_y][chunk_x].cells[cell_y][cell_x] = bit;
                    has_live_cells |= bit;
                }
            }
            if (has_live_cells){
                lowest_rightmost_live_chunk = QPoint(chunk_x, chunk_y);
            }
        }
    }

    QString filepath = QFileDialog::getSaveFileName(
                           this,
                           "Choose write location",
                           QStandardPaths::standardLocations(QStandardPaths::DesktopLocation).at(0),
                           "GOL MIF files (*.gmif)"
                        );

    QFile file(filepath, this);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Truncate)){
        printf("Failed to open file\n");
        return;
    }

    QTextStream tstream(&file);

    tstream << QString("ChunkRows:\n%1\nChunkCols:\n%2\n").arg(num_chunk_rows).arg(num_chunk_cols);

    for (int chunk_y = 0; chunk_y < num_chunk_rows; ++chunk_y){
        bool broken = false;
        for (int chunk_x = 0; chunk_x < num_chunk_cols; ++chunk_x){
            QString vector_str = this->chunk_to_vector(block[chunk_y][chunk_x]);
            tstream << vector_str << "\n";
//            if (chunk_x > lowest_rightmost_live_chunk.x() && chunk_y > lowest_rightmost_live_chunk.y()){
//                broken = true;
//                break;
//            }
        }
        if (broken) break;
    }

    file.close();
}

void MainWindow::loadState(){
    QString filepath = QFileDialog::getOpenFileName(
                           this, 
                           "Choose file to load", 
                           QStandardPaths::standardLocations(QStandardPaths::DesktopLocation).at(0),
                           "GOL MIF files (*.gmif)"
                        );
    
    QFile file(filepath, this);
    if (!file.open(QIODevice::ReadOnly)){
        printf("Failed to open file\n");
        return;
    }
    
    QTextStream tstream(&file);

    tstream.readLine();
    QString rows_str = tstream.readLine();
    tstream.readLine();
    QString cols_str = tstream.readLine();
    bool ok;

    int chunk_rows = rows_str.toInt(&ok);
    if (!ok){
        fprintf(stderr, "Row int conversion failed in header of %s.\n", filepath.toUtf8().constData());
    }
    this->num_chunk_rows = chunk_rows;
    this->num_cell_rows = CHUNK_HEIGHT*num_chunk_rows;

    int chunk_cols = cols_str.toInt(&ok);
    if (!ok){
        fprintf(stderr, "Col int conversion failed in header of %s.\n", filepath.toUtf8().constData());
    }
    this->num_chunk_cols = chunk_cols;
    this->num_cell_cols = CHUNK_WIDTH*num_chunk_cols;

    this->GOL_image = QImage(num_cell_cols, num_cell_rows, QImage::Format_Mono);
    this->GOL_image.fill(0);
    
    for (int chunk_y = 0; chunk_y < num_chunk_rows; ++chunk_y){
        bool broken = false;
        for (int chunk_x = 0; chunk_x < num_chunk_cols; ++chunk_x){
            if (tstream.atEnd()){
                fprintf(stderr, "File ended early!\n");
                broken = true;
                break;
            }
            QString vector = tstream.readLine();
            chunk_struct chunk = this->vector_to_chunk(vector);
            for (int cell_y = 0; cell_y < CHUNK_HEIGHT; ++cell_y){
                for (int cell_x = 0; cell_x < CHUNK_WIDTH; ++cell_x){
                    int block_y = chunk_y*CHUNK_HEIGHT + cell_y;
                    int block_x = chunk_x*CHUNK_WIDTH + cell_x;
                    QRgb pixel = 0;
                    if (chunk.cells[cell_y][cell_x]){
                        pixel = 1;
                    }
                    this->GOL_image.setPixel(block_x, block_y, pixel);
                }
            }
        }
        if (broken) break;
    }

    if (!tstream.atEnd()){
        fprintf(stderr, "File has more lines, but image is filled!\n");
    }

    this->pm_item->setPixmap(QPixmap::fromImage(this->GOL_image));

    file.close();
}

QString MainWindow::chunk_to_vector(chunk_struct chunk){
    QString ans;
    for (int cell_y = CHUNK_HEIGHT-1; cell_y >= 0; --cell_y){
        for (int cell_x = CHUNK_WIDTH-1; cell_x >= 0; --cell_x){
            if (chunk.cells[cell_y][cell_x]){
                ans.append('1');
            } else {
                ans.append('0');
            }
        }
    }
    return ans;
}

chunk_struct MainWindow::vector_to_chunk(QString vector){
    chunk_struct ans({{
                          {true, false, false, false, false, true},
                          {false, true, false, false, true, false},
                          {false, false, true, true, false, false},
                          {false, false, true, true, false, false},
                          {false, true, false, false, true, false},
                          {true, false, false, false, false, true},
                      }});
    if (vector.length() != CHUNK_HEIGHT*CHUNK_WIDTH){
        fprintf(stderr, "Vector length is %d chars, expected %d\n", vector.length(), CHUNK_HEIGHT*CHUNK_WIDTH);
        fprintf(stderr, "Vector: %s\n", vector.toUtf8().constData());
        return ans;
    }
    for (int cell_y = CHUNK_HEIGHT-1; cell_y >= 0; --cell_y){
        for (int cell_x = CHUNK_WIDTH-1; cell_x >= 0; --cell_x){
            if (vector.at(0) == '1'){
                ans.cells[cell_y][cell_x] = true;
            } else {
                ans.cells[cell_y][cell_x] = false;
            }
            //remove first character to make this easy
            vector.remove(0, 1);
        }
    }
    return ans;
}

void MainWindow::handlePixelClick(QPoint p){
    
    if (p.x() < 0 || p.x() >= this->GOL_image.width()) return;
    if (p.y() < 0 || p.y() >= this->GOL_image.height()) return;
    
    //printf("Got valid pixel change at %d, %d\n", p.x(), p.y());
    
    int old_val = qGray(this->GOL_image.pixel(p)) & pixel_mask;
    int new_val = old_val;
    
    switch(this->dragging_state){
    case NOT_DRAGGING:
        if (old_val){
            this->dragging_state = DRAGGING_PIXELS_OFF;
            new_val = 0;
        } else {
            this->dragging_state = DRAGGING_PIXELS_ON;
            new_val = 1;
        }
        break;
    case DRAGGING_PIXELS_ON:
        new_val = 1;
        break;
    case DRAGGING_PIXELS_OFF:
        new_val = 0;
        break;
    default:
        fprintf(stderr, "Undefined dragging state: %u\n", this->dragging_state);
        break;
    }
    if (new_val != old_val){
        this->GOL_image.setPixel(p, new_val);
        this->pm_item->setPixmap(QPixmap::fromImage(this->GOL_image));
    }
}

void MainWindow::handleMouseRelease(){
    this->dragging_state = NOT_DRAGGING;
}

void MainWindow::on_doubleSpinBox_valueChanged(double new_val) {
    double scale_ratio = new_val/this->old_scale;
    this->ui->GOLgraphicsView->scale(scale_ratio, scale_ratio);
    this->old_scale = new_val;
}

void MainWindow::on_saveButton_clicked(){
    this->saveState();
}

void MainWindow::on_loadButton_clicked(){
    this->loadState();
}

void MainWindow::on_clearButton_clicked()
{
    this->clearImage();
}

void MainWindow::on_chunkColsSpinbox_editingFinished()
{
    int new_num_chunk_cols = this->ui->chunkColsSpinbox->value();
    int new_num_cell_cols = new_num_chunk_cols*CHUNK_WIDTH;

    QImage new_image(new_num_cell_cols, this->num_cell_rows, this->GOL_image.format());
    new_image.fill(0);
    for (int y = 0; y < this->num_cell_rows; ++y){
        for (int x = 0; x < std::min(this->num_cell_cols, new_num_cell_cols); ++x){
            new_image.setPixel(x, y, this->GOL_image.pixel(x, y) & pixel_mask);
        }
    }
    this->GOL_image = new_image;

    this->num_cell_cols = new_num_cell_cols;
    this->num_chunk_cols = new_num_chunk_cols;

    this->pm_item->setPixmap(QPixmap::fromImage(this->GOL_image));
}

void MainWindow::on_chunkRowsSpinbox_editingFinished()
{
    int new_num_chunk_rows = this->ui->chunkRowsSpinbox->value();
    int new_num_cell_rows = new_num_chunk_rows*CHUNK_HEIGHT;

    QImage new_image(this->num_cell_cols, new_num_cell_rows, this->GOL_image.format());
    new_image.fill(0);
    for (int y = 0; y < std::min(this->num_cell_rows, new_num_cell_rows); ++y){
        for (int x = 0; x < this->num_cell_cols; ++x){
            new_image.setPixel(x, y, this->GOL_image.pixel(x, y) & pixel_mask);
        }
    }
    this->GOL_image = new_image;

    this->num_cell_rows = new_num_cell_rows;
    this->num_chunk_rows = new_num_chunk_rows;

    this->pm_item->setPixmap(QPixmap::fromImage(this->GOL_image));
}
