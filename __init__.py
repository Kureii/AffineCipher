import GUI
from Lang import cs_CZ



class Run():
    def __init__(self):
        MyGUI = GUI.runQML(cs_CZ)
        MyGUI.exec()


if __name__ == '__main__':
    Run()
