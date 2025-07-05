import nigui
import osproc
import strutils
import strformat

app.init()

var voice = "alicja"
var engine = "rhvoice"
try:
  let config = readFile("config.txt")
  for line in config.splitLines():
    if line.startsWith("voice="):
      voice = line.split('=')[1].strip()
    if line.startsWith("engine="):
      engine = line.split('=')[1].strip()
except:
  discard

var sentences: seq[tuple[polish: string, english: string, frequency: string]] = @[]
let lines = readFile("sentences.tsv").splitLines()
for i, line in lines:
  if i == 0 or line.strip() == "": continue
  let parts = line.split('\t')
  if parts.len >= 3:
    sentences.add((polish: parts[0], english: parts[1], frequency: parts[2]))

var currentIndex = 0
var rangeStart = 1
var rangeEnd = sentences.len

var window = newWindow("Flashcards")
window.width = 500
window.height = 120

var label = newLabel("")
label.fontSize = 24
label.text = if sentences.len > 0: sentences[currentIndex].polish else: "No data"

var labelContainer = newLayoutContainer(Layout_Horizontal)
labelContainer.widthMode = WidthMode_Fill
labelContainer.heightMode = HeightMode_Expand
labelContainer.xAlign = XAlign_Center

var meaningButton = newButton("Meaning")
var nextButton = newButton("Next")

var rangeContainer = newLayoutContainer(Layout_Horizontal)
rangeContainer.widthMode = WidthMode_Fill
rangeContainer.xAlign = XAlign_Center

var rangeStartBox = newTextBox($rangeStart)
var rangeEndBox = newTextBox($rangeEnd)
var rangeLabel = newLabel("Range:")
var toLabel = newLabel("to")
var applyRangeButton = newButton("Apply")

rangeContainer.add(rangeLabel)
rangeContainer.add(rangeStartBox)
rangeContainer.add(toLabel)
rangeContainer.add(rangeEndBox)
rangeContainer.add(applyRangeButton)

var container = newLayoutContainer(Layout_Vertical)
container.xAlign = XAlign_Center
container.yAlign = YAlign_Center
container.widthMode = WidthMode_Fill
container.heightMode = HeightMode_Fill

var buttonContainer = newLayoutContainer(Layout_Horizontal)
buttonContainer.xAlign = XAlign_Center
buttonContainer.yAlign = YAlign_Center
buttonContainer.widthMode = WidthMode_Fill

window.add(container)
container.add(labelContainer)
labelContainer.add(label)
container.add(buttonContainer)
buttonContainer.add(meaningButton)
buttonContainer.add(nextButton)
container.add(rangeContainer)

proc updateDisplay() =
  if currentIndex >= rangeStart-1 and currentIndex < rangeEnd:
    label.text = sentences[currentIndex].polish
  else:
    currentIndex = rangeStart-1
    label.text = sentences[currentIndex].polish

proc updateRange() =
  try:
    rangeStart = parseInt(rangeStartBox.text)
    rangeEnd = parseInt(rangeEndBox.text)
    if rangeStart < 1: rangeStart = 1
    if rangeEnd > sentences.len: rangeEnd = sentences.len
    if rangeStart > rangeEnd: rangeStart = rangeEnd
    currentIndex = rangeStart-1
    updateDisplay()
  except:
    discard

label.onClick = proc(event: ClickEvent) =
  if currentIndex >= 0 and currentIndex < sentences.len:
    case engine:
    of "espeak":
      discard execCmd(fmt"espeak-ng -v {voice} '{sentences[currentIndex].polish}'")
    else:
      discard execCmd(fmt"echo '{sentences[currentIndex].polish}' | /snap/bin/rhvoice.test -p " & voice)

meaningButton.onClick = proc(event: ClickEvent) =
  if currentIndex >= 0 and currentIndex < sentences.len:
    window.alert(sentences[currentIndex].english)

nextButton.onClick = proc(event: ClickEvent) =
  currentIndex += 1
  if currentIndex >= rangeEnd:
    currentIndex = rangeStart-1
  updateDisplay()
  # These lines auto play the audio if you press next. I do not like the way it works currently, but it is functional so i am leaving it here...
  #if currentIndex >= 0 and currentIndex < sentences.len:
    #discard execCmd(fmt"echo '{sentences[currentIndex].polish}' | /snap/bin/rhvoice.test -p alicja")

applyRangeButton.onClick = proc(event: ClickEvent) =
  updateRange()

if sentences.len > 0:
  case engine:
  of "espeak":
    discard execCmd(fmt"espeak-ng -v {voice} '{sentences[0].polish}'")
  else:
    discard execCmd(fmt"echo '{sentences[0].polish}' | /snap/bin/rhvoice.test -p " & voice)

window.show()
app.run()
