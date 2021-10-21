import os
import sys
from typing import Text
from PySide6 import QtCore
from PySide6.QtCore import *
from PySide6.QtQml import *
from PySide6.QtWidgets import *
from PySide6.QtCore import QObject, Slot, Signal
from PySide6.QtGui import *
import PySide6
import Lang
import Fce


class GetData(QObject):
    def __init__(self):
        QObject.__init__(self)
    
    Text = ""

    # False = naive, True = modern
    Type = True
    InputIndex = False 
    Alpha = ""
    Shift = 0
    RepSpc = ""
    OutSpc = 0
    ilCh = []
    myAbcList = []

    @Slot(bool)
    def getInputIndex(self, index):
        self.InputIndex = index

    @Slot(str)
    def getAbc(self, abc):
        self.Alpha = abc

    @Slot(str)
    def getInput(self, myInput):
        if self.InputIndex:
            if os.name == "nt":
                File = myInput[8:]
            else:
                File = myInput[7:]
            f = open(File, "r")
            self.Text = f.read()
            if self.Alpha.isupper():
                self.Text = self.Text.upper()
        else:
            self.Text = myInput
    
    @Slot(bool)
    def getType(self, index):
        self.Type = index


    @Slot(int)
    def getShift(self, shift):
        self.Shift = shift

    @Slot(str)
    def getRepSpaces(self, RpSpc):
        self.RepSpc = RpSpc

    @Slot(int)
    def getOutputSpaces(self, myOpSpc):
        self.OutSpc = myOpSpc

    repCount = Signal(int)
    abcList = Signal(list)
    illegalChars = Signal(list)
    

    @Slot()
    def encode(self):
        if not self.Type:
            self.ilCh = []
            ilCh = Fce.IlChar(self.Alpha, self.Text)
            indx = 0
            for i in ilCh:
                if i == " ":
                    del ilCh[indx]
                    break
                indx += 1
            if not ilCh:
                print(Fce.Naive(self.Alpha, self.Text, self.RepSpc, self.Shift, True, self.OutSpc).output)
            else:
                self.repCount.emit(len(ilCh))
                self.myAbcList = Fce.makeList(self.Alpha)
                self.abcList.emit(self.myAbcList)
                self.illegalChars.emit(ilCh)
                self.ilCh = ilCh
        else:
            pass

    @Slot()
    def decode(self):
        if not self.Type:
            print("decode")
        else:
            pass

    @Slot(list)
    def repair(self, myList):
        myAbc = self.Alpha
        for i in range(len(self.ilCh)):
            if myList[i][0] == 0:
                self.Text = self.Text.replace(self.ilCh[i], "")
            elif myList[i][0] == 1:
                self.Alpha += self.ilCh[i]
            else:
                self.Text = self.Text.replace(self.ilCh[i], self.myAbcList[myList[i][1]])
        print(self.Text)


#--------------------------------------------------------------------------------

class GetCircleData(QObject):
    def __init__(self):
        QObject.__init__(self)
    

    Alphabet = ""
    UpCases = False

    Alpha = Signal(str)
    UpperCases = Signal(bool)

    @Slot(bool)
    def isUpper(self, upperCase):
        self.UpCases = not upperCase

    @Slot(str)
    def myAlpha(self, myAlpha):
        tmp = str(myAlpha)
        if self.UpCases:
            self.Alphabet = tmp.upper()
        else:
            self.Alphabet = tmp
        Values = Fce.myValues(self.Alphabet)
        Fce.editCircle(Values.smallRadius, Values.smallFont, Values.smallStr, "icons/CustomSmallCircle", "Regular", '#201e1b', '#3fa108',350)
        Fce.editCircle(Values.bigRadius, Values.bigFont, Values.bigStr, "icons/CustomBigCircle", "Medium", '#201e1b', '#e4f8ff', 420, True)


            


class runQML():
    def __init__(self, dic= {}):
        sys_argv = sys.argv
        sys_argv += ['--style', 'Fusion']
        self.app = QApplication(sys_argv)
        app_icon = PySide6.QtGui.QIcon()
        app_icon.addFile('icons/TaskBar.svg')
        self.app.setWindowIcon(app_icon)
        QFontDatabase.addApplicationFont('fonts/Poppins-Medium.ttf')
        QFontDatabase.addApplicationFont('fonts/Roboto-Medium.ttf')
        self.engine = QQmlApplicationEngine()

        self.abc = GetCircleData()
        self.engine.rootContext().setContextProperty("myDrawCircle", self.abc)

        self.getD =  GetData()
        self.engine.rootContext().setContextProperty("myData", self.getD)

        self.engine.load('main.qml')
        if dic: # no dictionary = english
            for i in dic:
                self.engine.rootObjects()[0].setProperty(i, dic[i])
        self.engine.rootObjects()[0].setProperty("homePath", os.path.expanduser('~'))



        
    def exec(self):
        if not self.engine.rootObjects():
            return -1     
        return self.app.exec()

if __name__ == '__main__':
    GUI = runQML(Lang.cs_CZ)
    GUI.exec()