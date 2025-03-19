import sys
from PyQt5.QtWidgets import *


class DevWin(QMainWindow): 
    def __init__(self):    
        super().__init__()  
        self.setWindowTitle('My First App') # 윈도우 타이틀 지정


app = QApplication(sys.argv)    
win = DevWindow()              
win.show()                    
app.exec_()                   