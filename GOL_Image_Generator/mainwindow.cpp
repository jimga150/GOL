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

    this->on_chunkColsSpinbox_editingFinished();
    this->on_chunkRowsSpinbox_editingFinished();
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::clearImage(){
    this->GOL_image.fill(0);
    this->pm_item->setPixmap(QPixmap::fromImage(this->GOL_image));
}

void MainWindow::copyConstDecl(){
    std::vector<std::vector<chunk_struct>> block;
    std::vector<int> rightmost_live_col;
    int lowest_live_row = -1;

    for (int chunk_y = 0; chunk_y < num_chunk_rows; ++chunk_y){
        std::vector<chunk_struct> chunk_row;
        block.push_back(chunk_row);
        rightmost_live_col.push_back(-1);
        for (int chunk_x = 0; chunk_x < num_chunk_cols; ++chunk_x){
            chunk_struct chunk;
            block[chunk_y].push_back(chunk);
            bool chunk_is_live = false;
            for (int cell_y = 0; cell_y < CHUNK_HEIGHT; ++cell_y){
                for (int cell_x = 0; cell_x < CHUNK_WIDTH; ++cell_x){
                    int block_y = chunk_y*CHUNK_HEIGHT + cell_y;
                    int block_x = chunk_x*CHUNK_WIDTH + cell_x;
                    QRgb pixel = this->GOL_image.pixel(block_x, block_y);
                    bool bit = pixel & pixel_mask;
                    block[chunk_y][chunk_x].cells[cell_y][cell_x] = bit;
                    chunk_is_live |= bit;
                }
            }
            if (chunk_is_live){
                rightmost_live_col.at(chunk_y) = chunk_x;
                lowest_live_row = chunk_y;
            }
        }
    }

    QString decl = "constant c_init_<name> : t_field_chunk_arr := (%1);";

    QString row_decl = "%1 => (%2),";
    QStringList row_decls;
    row_decls.append("\n\t\t");

    int y_max = num_chunk_rows-1;
    if (lowest_live_row < y_max){
        y_max = lowest_live_row;
    }

    for (int chunk_y = 0; chunk_y <= y_max; ++chunk_y){

        QString col_decl = "%1 => %2,";
        QStringList col_decls;
        col_decls.append("\n\t\t\t");

        int x_max = num_chunk_cols-1;
        if (rightmost_live_col[chunk_y] < x_max){
            x_max = rightmost_live_col[chunk_y];
        }

        if (x_max < 0){
            continue;
        }

        for (int chunk_x = 0; chunk_x <= x_max; ++chunk_x){
            if (!block[chunk_y][chunk_x].isLive()){
                continue;
            }
            col_decls.append(col_decl.arg(chunk_x).arg(block[chunk_y][chunk_x].constDecl()));
            col_decls.append(col_decls.at(0));
        }

        col_decls.append("others => c_empty_chunk\n\t\t");

        QString col_decls_str = col_decls.join("");
        row_decls.append(row_decl.arg(chunk_y).arg(col_decls_str));
        row_decls.append(row_decls.at(0));
    }

    row_decls.append("others => (others => c_empty_chunk)\n\t");

    QString row_decls_str = row_decls.join("");
    decl = decl.arg(row_decls_str);
    decl.replace("\t", "    ");

    printf("Declaration:\n%s\n", decl.toUtf8().constData());
    fflush(stdout);

    QClipboard* clipboard = QGuiApplication::clipboard();
    clipboard->setText(decl);

    QMessageBox::information(this, "GOL Image Generator", "Declatation copied!");
}

void MainWindow::saveStateGMIF(){

    std::vector<std::vector<chunk_struct>> block;

    for (int chunk_y = 0; chunk_y < num_chunk_rows; ++chunk_y){
        std::vector<chunk_struct> chunk_row;
        block.push_back(chunk_row);
        for (int chunk_x = 0; chunk_x < num_chunk_cols; ++chunk_x){
            chunk_struct chunk;
            block[chunk_y].push_back(chunk);
            for (int cell_y = 0; cell_y < CHUNK_HEIGHT; ++cell_y){
                for (int cell_x = 0; cell_x < CHUNK_WIDTH; ++cell_x){
                    int block_y = chunk_y*CHUNK_HEIGHT + cell_y;
                    int block_x = chunk_x*CHUNK_WIDTH + cell_x;
                    QRgb pixel = this->GOL_image.pixel(block_x, block_y);
                    bool bit = pixel & pixel_mask;
                    block[chunk_y][chunk_x].cells[cell_y][cell_x] = bit;
                }
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
        }
        if (broken) break;
    }

    file.close();
}

void MainWindow::loadStateGMIF(){
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
    this->ui->chunkRowsSpinbox->setValue(chunk_rows);

    int chunk_cols = cols_str.toInt(&ok);
    if (!ok){
        fprintf(stderr, "Col int conversion failed in header of %s.\n", filepath.toUtf8().constData());
    }
    this->num_chunk_cols = chunk_cols;
    this->num_cell_cols = CHUNK_WIDTH*num_chunk_cols;
    this->ui->chunkColsSpinbox->setValue(chunk_cols);

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
    this->saveStateGMIF();
}

void MainWindow::on_loadButton_clicked(){
    this->loadStateGMIF();
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

    this->ui->pixColsSpinbox->setValue(new_num_cell_cols);

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

    this->ui->pixRowsSpinbox->setValue(new_num_cell_rows);

    this->pm_item->setPixmap(QPixmap::fromImage(this->GOL_image));
}

void MainWindow::on_copyDeclButton_clicked()
{
    this->copyConstDecl();
}


void MainWindow::on_pixColsSpinbox_editingFinished()
{
    float pixels = this->ui->pixColsSpinbox->value();
    int chunks = ceil(pixels/CHUNK_WIDTH);
    this->ui->chunkColsSpinbox->setValue(chunks);
    this->on_chunkColsSpinbox_editingFinished();
}


void MainWindow::on_pixRowsSpinbox_editingFinished()
{
    float pixels = this->ui->pixRowsSpinbox->value();
    int chunks = ceil(pixels/CHUNK_HEIGHT);
    this->ui->chunkRowsSpinbox->setValue(chunks);
    this->on_chunkRowsSpinbox_editingFinished();
}

