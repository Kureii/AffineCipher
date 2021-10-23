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
    savePath = ""
    outText =""
    myA = 0
    myB = 0

    repCount = Signal(int)
    abcList = Signal(list)
    illegalChars = Signal(list)
    finalAbc = Signal(str)
    openText = Signal(str)
    encodeText = Signal(str)

    @Slot(bool)
    def getInputIndex(self, index):
        self.InputIndex = index

    @Slot(str)
    def getAbc(self, abc):
        self.Alpha = ""
        for line in abc:
            oneLine = line.rstrip()
            self.Alpha += oneLine

    @Slot(str)
    def getInput(self, myInput):
        self.Text = ""
        if self.InputIndex:
            if os.name == "nt":
                File = myInput[8:]
            else:
                File = myInput[7:]
            f = open(File, "r")
            myText = f.read()
            if self.Alpha.isupper():
                myText = myText.upper()
            f.close()

            
        else:
            myText = myInput

        for line in myText:
            oneLine = line.rstrip("\n")
            self.Text += oneLine

        self.openText.emit(self.Text)


    
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

    @Slot(int, int)
    def getAB(self, a, b):
        self.myA = a
        self.myB = b

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
                self.finalAbc.emit(self.Alpha)
                myText = self.Text
                if not self.RepSpc:
                    myText = myText.replace(" ", "")
                self.openText.emit(myText)
                self.outText = Fce.Naive(self.Alpha, self.Text, self.RepSpc, self.Shift, True, self.OutSpc).output
                self.encodeText.emit(self.outText)
            else:
                self.openText.emit(self.Text)
                self.repCount.emit(len(ilCh))
                self.myAbcList = Fce.makeList(self.Alpha)
                self.abcList.emit(self.myAbcList)
                self.illegalChars.emit(ilCh)
                self.ilCh = ilCh
        else:
            self.ilCh = []
            ilCh = Fce.IlChar(self.Alpha, self.Text)
            indx = 0
            for i in ilCh:
                if i == " ":
                    del ilCh[indx]
                    break
                indx += 1

            if not ilCh:
                self.finalAbc.emit(self.Alpha)
                myText = self.Text
                if not self.RepSpc:
                    myText = myText.replace(" ", "")
                self.openText.emit(myText)
                self.outText = Fce.Modern(self.Alpha, self.Text, self.RepSpc, self.myA, self.myB, True, self.OutSpc).output
                self.encodeText.emit(self.outText)
            else:
                self.openText.emit(self.Text)
                self.repCount.emit(len(ilCh))
                self.myAbcList = Fce.makeList(self.Alpha)
                self.abcList.emit(self.myAbcList)
                self.illegalChars.emit(ilCh)
                self.ilCh = ilCh

    @Slot()
    def decode(self):
        self.Alpha = self.Alpha.replace("\n", "")
        if not self.Type:
            self.finalAbc.emit(self.Alpha)
            self.outText = Fce.Naive(self.Alpha, self.Text, self.RepSpc, self.Shift, False, self.OutSpc).output
            self.openText.emit(self.outText)
            self.encodeText.emit(self.Text)
        else:
            self.finalAbc.emit(self.Alpha)
            self.outText = Fce.Modern(self.Alpha, self.Text, self.RepSpc, self.myA, self.myB, False, self.OutSpc).output
            self.openText.emit(self.outText)
            self.encodeText.emit(self.Text)

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

    @Slot(str)
    def getSaveFile(self, path):
        if os.name == "nt":
            File = path[8:]
        else:
            File = path[7:]
        f = open(File, "w")
        f.write(self.outText)
        f.close()
        

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
        tmp2 = ""
        for line in tmp:
            oneLine = line.rstrip()
            tmp2 += oneLine
        if self.UpCases:
            self.Alphabet = tmp2.upper()
        else:
            self.Alphabet = tmp2
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