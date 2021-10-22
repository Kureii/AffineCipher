from cairosvg import svg2png
import math

def Steps(string, steps):
    Lenght = len(string)
    iterations = math.ceil(Lenght / steps)
    newString =""
    for i in range(iterations):
        for j in range(steps):
            index = i * steps + j
            if index < Lenght:
                newString += string[index]
        newString += " "
    
    return newString

def IlChar(abc, text):
    output = []
    if abc.isupper():
        text = text.upper()
    for i in text:
        if i not in abc:
            output.append(i)
    output =list(dict.fromkeys(output))
    return output

def makeList(str):
    output = []
    for i in str:
        output.append(i)
    return output


class Naive():
    """Encode decode, naive addine cipher
        Attributes:
            abc (str). alphabet
            string (str). input string
            spacesStr (str): string that replaces spaces
            shift (int): number of alphabet shift
            encode (bool): True == encode, False == Decode
    """
    def __init__(self, abc, string, spacesStr, shift, encode, myStep = 0):
        
        if not isinstance(abc, str):
            raise Exception(f'{abc} is not string')
        if not isinstance(string, str):
            raise Exception(f'{string} is not string')
        if not isinstance(spacesStr, str):
            raise Exception(f'{spacesStr} is not string')
        if not isinstance(shift, int):
            raise Exception(f'{shift} is not int')
        if not isinstance(encode, bool):
            raise Exception(f'{encode} is not bool')

        self.abc = abc
        self.string = string 
        self.spaceStr = spacesStr 
        self.shift = shift
        self.encode = encode

        #Solve spaces encode / decode
        self.spaceSolver() #ok

        #Make dict from string
        self.dicAbc = {}
        self.makeDict()

        #Make shifted dict from shift, encode and abcDic
        self.dicAbcShifted = {}
        self.shiftDict()

        #Make inverse dict from string
        self.dicAbcInverse = {}
        if self.encode:
            self.inverseDict(self.abc)
        else:
            shiftedAbc = ""
            for i in self.dicAbcShifted:
                shiftedAbc += self.dicAbcShifted[i]
            self.inverseDict(shiftedAbc)
            


        #Make list of index from input sting by dicAbcInverse
        self.indexList = []
        self.str2index()

        #Make output string from indexList by dicAbcShifted
        self.output = ""
        if encode:
            self.index2str(self.dicAbcShifted)
        else:
            self.index2str(self.dicAbc)

        if not encode:
            self.spaceSolver(1)
        else:
            if myStep > 0:
                self.output = Steps(self.output, myStep)


    def makeDict(self):
        """Make dictionary from string ('int key' : 'char index')"""
        myDic = {}
        for i in range(len(self.abc)):
            myDic[i] = self.abc[i]
        self.dicAbc = myDic
    
    def inverseDict(self, abc):
        """Make dictionary from string ('char key' : 'int index')"""
        myDic = {}
        for i in range(len(abc)):
            myDic[abc[i]] = i
        self.dicAbcInverse = myDic

    def spaceSolver(self, myPass = 0):
        """Replace spaces by spaceStr"""
        if self.encode:
            self.string = self.string.replace(" ", self.spaceStr)
        else:
            if myPass == 0:
                self.string = self.string.replace(" ", "")
            else:
                if self.spaceStr:
                    self.output = self.output.replace(self.spaceStr, " ")
                    
                    

    def shiftDict(self):
        """Shift dict key by shift value"""
        myLen = len(self.dicAbc)
        newDic = {}
        j = 0
        for i in range(myLen - self.shift ,myLen):
            newDic[j] = self.dicAbc[i]
            j += 1
        for i in range(0, myLen - self.shift):
            newDic[j]= self.dicAbc[i]
            j += 1
        self.dicAbcShifted = newDic

    def str2index(self):
        """Make indexList from string by dicAbcInverse"""
        indexList = []
        for i in self.string:
            indexList.append(self.dicAbcInverse[i])
        self.indexList = indexList
    
    def index2str(self,dic):
        """Make string from indexList by dic"""
        string = ""
        for i in self.indexList:
            string += dic[i]
        self.output = string


class myValues():
    def __init__(self, string):
        self.string = string
        self.smallFont = 8
        self.smallSpace = 0
        self.smallStr = self.editStr(self.smallSpace)
        self.smallRadius = self.radius(605, self.smallSpace, self.smallStr, self.smallFont)
        self.bigFont = 9
        self.bigSpace = 1
        self.bigStr = self.editStr(self.bigSpace)
        self.bigRadius = self.radius(538, self.bigSpace, self.bigStr, self.bigFont)
        

    def radius(self, charWidth, spaces, string, fontSize):
        lstr = len(string)
        circuit = charWidth / 1000
        circuit *= fontSize * 2
        circuit *= lstr
        radi = circuit / (math.pi * 2)
        return radi

    def editStr(self, spaces):
        newString = ""
        for i in range(0, len(self.string)):
            tmp = self.string[i]
            for j in range(0, spaces):
                tmp = " " + tmp + " "
            newString += tmp + "|"
        return newString
    

class editCircle():
    def __init__(self, radius, fontSize, string, fileName, fontWidth, colorFill, colorText,size, line=False):
        font = fontSize
        fontSpace = 1.75 * font
        page = radius * 2 + fontSpace * 2
        halfPage = page / 2
        coords = (halfPage, fontSpace,
                  page - fontSpace, halfPage,
                  halfPage, page - fontSpace,
                  fontSpace, halfPage)
        c = 4 * (math.sqrt(2) - 1) / 3
        bezi = (c * (halfPage - fontSpace) + halfPage, fontSpace, page - fontSpace, (c * (halfPage - fontSpace) - halfPage) * -1,
               page - fontSpace, c * (halfPage - fontSpace) + halfPage, c * (halfPage - fontSpace) + halfPage,  page - fontSpace,
               (c * (halfPage - fontSpace) - halfPage) * -1, page - fontSpace, fontSpace, c * (halfPage - fontSpace) + halfPage,
                fontSpace, (c * (halfPage - fontSpace) - halfPage) * -1, (c * (halfPage - fontSpace) - halfPage) * -1, fontSpace)


        DOC = f"""
        <svg viewBox="0 0 {page} {page}" xmlns="http://www.w3.org/2000/svg">
            <circle cx="{page / 2}" cy="{page / 2}" r="{(page - 1) / 2}" style="fill:{colorFill}"/>
            <path id="myPath" style="fill:none" d="M {coords[0]} {coords[1]} 
                C {bezi[0]} {bezi[1]} {bezi[2]} {bezi[3]} {coords[2]} {coords[3]}
                C {bezi[4]} {bezi[5]} {bezi[6]} {bezi[7]} {coords[4]} {coords[5]}
                C {bezi[8]} {bezi[9]} {bezi[10]} {bezi[11]} {coords[6]} {coords[7]} 
                C {bezi[12]} {bezi[13]} {bezi[14]} {bezi[15]} {coords[0]} {coords[1]}"/>"""

        if line:
            DOC += f"""<defs>
                <marker id="tris" viewBox="0 0 10 10" refX="5" refY="5" markerUnits="strokeWidth" makrerWidth="30" markerHeight="30" orient="180">
                    <path d="M 0 0 L 5 10 L 10 0 z" fill="{colorText}" />
                </marker>
            </defs>
            
            <path style='stroke:{colorText}' d='M {halfPage} {halfPage} V {fontSpace * 2}' marker-end='url(#tris)' stroke-width="4px"/>"""
        DOC +=    """<style type="text/css">
                @font-face {"""
        DOC +=            'font-family: "Fira Code", monospace;'
        DOC +=            f'rc: url("fonts/FiraCode-{fontWidth}.ttf");'
        DOC +=        '}'
        DOC +=   f"""</style>
            
            <text font-family="Fira Code" fill="{colorText}">
                <textPath href="#myPath" alignment-baseline="middle" startOffset="-2">
                    {string}
                </textPath>
            </text>
        </svg>"""
        svg2png(bytestring=DOC,write_to=fileName +'.png', scale=6)