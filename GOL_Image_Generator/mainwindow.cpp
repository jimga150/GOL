#include "mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    
    this->scene = new CustomScene();
    
    this->GOL_image = QImage(BLOCK_NUM_CELL_COLS, BLOCK_NUM_CELL_ROWS, QImage::Format_Mono);
    this->GOL_image.fill(0);
    
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

    chunk_struct block[BLOCK_NUM_CHUNK_ROWS][BLOCK_NUM_CHUNK_COLS];
    QPoint lowest_rightmost_live_chunk(0, 0);

    for (int chunk_y = 0; chunk_y < BLOCK_NUM_CHUNK_ROWS; ++chunk_y){
        for (int chunk_x = 0; chunk_x < BLOCK_NUM_CHUNK_COLS; ++chunk_x){
            bool has_live_cells = false;
            for (int cell_y = 0; cell_y < CHUNK_HEIGHT; ++cell_y){
                for (int cell_x = 0; cell_x < CHUNK_WIDTH; ++cell_x){
                    int block_y = chunk_y*CHUNK_HEIGHT + cell_y;
                    int block_x = chunk_x*CHUNK_WIDTH + cell_x;
                    QRgb pixel = this->GOL_image.pixel(block_x, block_y);
                    bool bit = pixel & PIXEL_MASK;
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
                           "MIF Files (*.mif)"
                        );

    QFile file(filepath, this);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Truncate)){
        printf("Failed to open file\n");
        return;
    }

    QTextStream tstream(&file);

    for (int chunk_y = 0; chunk_y < BLOCK_NUM_CHUNK_ROWS; ++chunk_y){
        bool broken = false;
        for (int chunk_x = 0; chunk_x < BLOCK_NUM_CHUNK_COLS; ++chunk_x){
            QString vector_str = this->chunk_to_vector(block[chunk_y][chunk_x]);
            tstream << vector_str << "\n";
            if (chunk_x > lowest_rightmost_live_chunk.x() && chunk_y > lowest_rightmost_live_chunk.y()){
                broken = true;
                break;
            }
        }
        if (broken) break;
    }

    file.close();
}

/*void MainWindow::saveState(){
    quint32 data[NUM_WORDS] = {0};
    int word[BITS_PER_WORD] = {0};
    
    
    for (int r = 0; r < this->GOL_image.height(); ++r){
        for (int c = 0; c < this->GOL_image.width(); ++c){
            int word_index = c % BITS_PER_WORD;
            word[word_index] = this->GOL_image.pixel(c, r);
            
            if (word_index == BITS_PER_WORD-1){
                quint32 packaged_word = 0;
                for (int i = 0; i < BITS_PER_WORD; ++i){
                    int bit_to_shift = word[i] & PIXEL_MASK;
//                    if (bit_to_shift){
//                        printf("found 1 bit at (%d, %d)\n", r, c - BITS_PER_WORD - 1 + i);
//                    }
                    packaged_word |= bit_to_shift << i;
                }
                data[this->getAddr(r, c/BITS_PER_WORD)] = packaged_word;
            }
        }
    }
    
    QString filepath = QFileDialog::getSaveFileName(
                           this, 
                           "Choose write location", 
                           QStandardPaths::standardLocations(QStandardPaths::DesktopLocation).at(0),
                           "All Files (*.*)"
                        );
    
    QFile file(filepath, this);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Truncate)){
        printf("Failed to open file\n");
        return;
    }
    
    QDataStream streamer(&file);
    
    for (int w = 0; w < NUM_WORDS; ++w){
        printf("%u: Writing 0x%08x\n", w, data[w]);
        char* c = (char*)&(data[w]);
#ifdef REVERSE_ENDIANNESS
        for (int i = 3; i >= 0; --i){
#else
        for (int i = 0; i < 4; ++i){
#endif
            streamer.writeRawData(&c[i], 1);
        }
    }
    file.close();
}*/

void MainWindow::loadState(){
    QString filepath = QFileDialog::getOpenFileName(
                           this, 
                           "Choose file to load", 
                           QStandardPaths::standardLocations(QStandardPaths::DesktopLocation).at(0),
                           "MIF files (*.mif)"
                        );
    
    QFile file(filepath, this);
    if (!file.open(QIODevice::ReadOnly)){
        printf("Failed to open file\n");
        return;
    }
    
    QTextStream stream(&file);
    
    for (int chunk_y = 0; chunk_y < BLOCK_NUM_CHUNK_ROWS; ++chunk_y){
        bool broken = false;
        for (int chunk_x = 0; chunk_x < BLOCK_NUM_CHUNK_COLS; ++chunk_x){
            if (stream.atEnd()){
                broken = true;
                break;
            }
            QString vector = stream.readLine();
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

    this->pm_item->setPixmap(QPixmap::fromImage(this->GOL_image));
}

/*void MainWindow::loadState(){
    QString filepath = QFileDialog::getOpenFileName(
                           this,
                           "Choose file to load",
                           QStandardPaths::standardLocations(QStandardPaths::DesktopLocation).at(0),
                           "All Files (*.*)"
                        );

    QFile file(filepath, this);
    if (!file.open(QIODevice::ReadOnly)){
        printf("Failed to open file\n");
        return;
    }

    QDataStream stream(&file);

    quint32 data[NUM_WORDS] = {0};

    for (int i = 0; i < NUM_WORDS; ++i){
        stream >> data[i];
        printf("%u: Reading out 0x%08x\n", i, data[i]);
    }

    for (int r = 0; r < this->GOL_image.height(); ++r){
        for (int c = 0; c < this->GOL_image.width(); ++c){
            quint32 packaged_word = data[this->getAddr(r, c/BITS_PER_WORD)];
            int word_index = c % BITS_PER_WORD;
            quint32 pixel = (packaged_word >> word_index) & PIXEL_MASK;
            this->GOL_image.setPixel(c, r, pixel);
        }
    }
    this->pm_item->setPixmap(QPixmap::fromImage(this->GOL_image));
}*/

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
    chunk_struct ans;
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

uint MainWindow::getAddr(uint row, uint col){
    return (row << COL_ADDR_BITS) + col;
}

void MainWindow::handlePixelClick(QPoint p){
    
    if (p.x() < 0 || p.x() >= this->GOL_image.width()) return;
    if (p.y() < 0 || p.y() >= this->GOL_image.height()) return;
    
    //printf("Got valid pixel change at %d, %d\n", p.x(), p.y());
    
    int old_val = qGray(this->GOL_image.pixel(p)) & PIXEL_MASK;
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
