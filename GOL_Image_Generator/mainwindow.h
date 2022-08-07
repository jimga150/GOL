#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QtMath>

#include <QGraphicsLineItem>
#include <QGraphicsSceneMouseEvent>
#include <QFileDialog>
#include <QStandardPaths>
#include <QTextStream>

#include <QMainWindow>
#include <QFile>
#include <QDataStream>
#include <QMouseEvent>
#include <QPoint>

#include "ui_mainwindow.h"
#include "CustomScene.h"


#define REVERSE_ENDIANNESS 1

#define pwrtwo(x) (1 << (x))

#define CHUNK_HEIGHT (6)
#define CHUNK_WIDTH (6)

#define BLOCK_NUM_CHUNK_ROWS (16)
#define BLOCK_NUM_CHUNK_COLS (32)

#define BLOCK_NUM_CELL_ROWS (CHUNK_HEIGHT*BLOCK_NUM_CHUNK_ROWS)
#define BLOCK_NUM_CELL_COLS (CHUNK_WIDTH*BLOCK_NUM_CHUNK_COLS)

#define BITS_PER_WORD (32)
#define PIXEL_MASK (1)
#define COL_WORDS (COLS/BITS_PER_WORD)

#define ROW_ADDR_BITS (5)
#define COL_ADDR_BITS (1)

#define NUM_ROWS pwrtwo(ROW_ADDR_BITS)
#define NUM_COLS pwrtwo(COL_ADDR_BITS)

#define NUM_WORDS NUM_ROWS*NUM_COLS

enum dragging_state_enum{
    NOT_DRAGGING = 0,
    DRAGGING_PIXELS_ON,
    DRAGGING_PIXELS_OFF,
    
    num_dragging_states
};

struct chunk_struct{
    bool cells[CHUNK_HEIGHT][CHUNK_WIDTH];
};

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT
    
public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();
    
    CustomScene* scene = nullptr;
    
    QGraphicsPixmapItem* pm_item = nullptr;
    
    double old_scale = 1.0;
    
    dragging_state_enum dragging_state = NOT_DRAGGING;

private:
    Ui::MainWindow *ui;
        
    QImage GOL_image;
    
    uint getAddr(uint row, uint col);
        
    void clearImage();
    
    void saveState();
    
    void loadState();

    QString chunk_to_vector(chunk_struct chunk);

    chunk_struct vector_to_chunk(QString vector);
    
private slots:
    
    void handlePixelClick(QPoint p);
    
    void handleMouseRelease();
    
    void on_doubleSpinBox_valueChanged(double arg1);
    
    void on_saveButton_clicked();
    
    void on_loadButton_clicked();
    void on_clearButton_clicked();
};
#endif // MAINWINDOW_H
