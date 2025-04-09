import sys
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from PyQt5 import QtWidgets, QtGui
from PyQt5.uic import loadUi
from PyQt5.QtCore import Qt

import cx_Oracle as oci

sid ='XE'
host = ' 210.119.14.60'
port = 1521
username = 'movie'
password = '1234'


class MainWindow(QDialog):
    def __init__(self):
        super(MainWindow, self).__init__()
        loadUi('mainpage.ui',self)
        print(widget.currentIndex())

        self.btn_search.clicked.connect(self.gotoSearch)
        self.btn_book.clicked.connect(self.gotoBookPage)
        # self.btn_book.setEnabled(False)

    def gotoSearch(self):
        widget.setCurrentIndex(widget.currentIndex()+1)
        print(widget.currentIndex())
    
    def gotoBookPage(self):
        widget.setCurrentIndex(widget.currentIndex()+2)
        print(widget.currentIndex())

class SearchPage(QDialog):
    def __init__(self):
        super(SearchPage,self).__init__()
        loadUi('searchpage.ui',self)

        self.btn_gotohome.clicked.connect(self.gotohome)
        self.btn_search.clicked.connect(self.startsearch)

    def gotohome(self):
        widget.setCurrentIndex(widget.currentIndex()-1)
        print(widget.currentIndex())

    def startsearch(self):
        std_ticket_id = self.input_key.text()
        if std_ticket_id == '':
            QMessageBox.warning(self, '오류', '예매번호를 입력해주세요')
        else:
            self.loadData(std_ticket_id) 

    def loadData(self, std_ticket_id):  
        conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
        cursor = conn.cursor()

        conn.begin() 

        query = '''
           SELECT user_id, name, phone_number, role_id
             FROM gallery
            WHERE user_id = :v_std_ticket_id
                '''

        cursor.execute(query, {'v_std_ticket_id': int(std_ticket_id)})

        lst_ticket = []
        for _, item in enumerate(cursor):
            lst_ticket.append(item)
        print(lst_ticket)
        self.makeTable(lst_ticket)

        cursor.close()
        conn.close()

    def makeTable(self,lst_ticket):
            self.inplbl_1.setText(str(lst_ticket[0][0]))
            self.inplbl_2.setText(str(lst_ticket[0][1]))
            self.inplbl_3.setText(str(lst_ticket[0][2]))
            self.inplbl_4.setText(str(lst_ticket[0][3]))

class BookPage1(QDialog):
    def __init__(self):
        super(BookPage1,self).__init__()
        loadUi('bookpage1.ui',self)
        self.btn_gohome.clicked.connect(self.goHome)
        self.btn_next.clicked.connect(self.goNext)

        self.btn_movie1.setIcon(QIcon('eximg.jpg'))
        self.btn_movie1.setIconSize(self.btn_movie1.size())

    def goHome(self):
        widget.setCurrentIndex(widget.currentIndex()-2)
        
    def goNext(self):
        widget.setCurrentIndex(widget.currentIndex()+1)

class BookPage2(QDialog):
    def __init__(self):
        super(BookPage2,self).__init__()
        loadUi('bookpage2.ui',self)
        self.btn_goback.clicked.connect(self.goBack)
        self.btn_next.clicked.connect(self.goNext)

    def goBack(self):
        widget.setCurrentIndex(widget.currentIndex()-1)
        print(widget.currentIndex())

    def goNext(self):
        widget.setCurrentIndex(widget.currentIndex()+1)

class BookPage3(QDialog):
    def __init__(self):
        super(BookPage3,self).__init__()
        loadUi('bookpage3.ui',self)
        self.btn_goback.clicked.connect(self.goBack)

        for i in range(1,9):
            btn_adt = getattr(self, f"btn_adt{i}")
            btn_teen = getattr(self, f"btn_teen{i}")
            btn_adt.clicked.connect(self.getAdultNumber)
            btn_teen.clicked.connect(self.getTeenNumber)

    def goBack(self):
        widget.setCurrentIndex(widget.currentIndex()-1)
        print(widget.currentIndex())

    def getAdultNumber(self):
        num_adt = 0
        btn = self.sender()
        if btn:
            num_adt = btn.text()
        self.input_adt.setText(num_adt)

    def getTeenNumber(self):
        num_teen = 0
        btn = self.sender()
        if btn:
            num_teen = btn.text()
        self.input_teen.setText(num_teen)

if __name__ == '__main__':
    app = QApplication(sys.argv)
    widget = QtWidgets.QStackedWidget()
    mainwindow = MainWindow()
    searchpage = SearchPage()
    bookpage1 = BookPage1()
    bookpage2 = BookPage2()
    bookpage3 = BookPage3()
    widget.addWidget(mainwindow)
    widget.addWidget(searchpage)
    widget.addWidget(bookpage1)
    widget.addWidget(bookpage2)
    widget.addWidget(bookpage3)
    widget.show()
    app.exec_()

    # 결제창에서 회원유무
    # 해당창에서 선택되지 않으면 다음페이지 못넘어가게 하기!!!!!!!!!!!!
