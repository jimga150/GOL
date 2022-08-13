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
#include <QClipboard>
#include <QMessageBox>

#include "ui_mainwindow.h"
#include "CustomScene.h"

#define CHUNK_HEIGHT (6)
#define CHUNK_WIDTH (6)


enum dragging_state_enum{
    NOT_DRAGGING = 0,
    DRAGGING_PIXELS_ON,
    DRAGGING_PIXELS_OFF,
    
    num_dragging_states
};

struct chunk_struct{
    bool cells[CHUNK_HEIGHT][CHUNK_WIDTH];

    bool isLive(){
        bool chunk_is_live = false;
        for (int y = CHUNK_HEIGHT-1; y >= 0; --y){
            for (int x = CHUNK_WIDTH-1; x >= 0; --x){
                chunk_is_live |= cells[y][x];
                if (chunk_is_live) break;
            }
            if (chunk_is_live) break;
        }
        return chunk_is_live;
    }

    QString constDecl(){

        if (!this->isLive()){
            return QString("c_empty_block");
        }

        QString ans;
        ans.append("(");
        for (int y = CHUNK_HEIGHT-1; y >= 0; --y){
            ans.append("\"");
            for (int x = CHUNK_WIDTH-1; x >= 0; --x){
                ans.append(cells[y][x] ? "1" : "0");
            }
            ans.append("\"");
            if (y > 0){
                ans.append(", ");
            }
        }
        ans.append(")");
        return ans;
    }
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
            
    void clearImage();

    void copyConstDecl();
    
    void saveStateGMIF();
    
    void loadStateGMIF();

    QString chunk_to_vector(chunk_struct chunk);

    chunk_struct vector_to_chunk(QString vector);

    int num_chunk_rows = 16;
    int num_chunk_cols = 32;

    int num_cell_rows = CHUNK_HEIGHT*num_chunk_rows;
    int num_cell_cols = CHUNK_WIDTH*num_chunk_cols;

    int pixel_mask = 0x1;
    
private slots:
    
    void handlePixelClick(QPoint p);
    
    void handleMouseRelease();
    
    void on_doubleSpinBox_valueChanged(double arg1);
    
    void on_saveButton_clicked();
    
    void on_loadButton_clicked();
    void on_clearButton_clicked();
    void on_chunkColsSpinbox_editingFinished();
    void on_chunkRowsSpinbox_editingFinished();
    void on_copyDeclButton_clicked();
};
#endif // MAINWINDOW_H
