# Heavily modified version of the other flashcards application. I think this code is ugly as shit.
import nigui
import osproc
import strutils

app.init()

var sentences: seq[tuple[original: string, translation: string, audioPath: string]] = @[]

# Ugly, but it works for shit inside quotes, like the tatoeba danish data...
proc parseCsvLine(line: string): seq[string] =
  var result: seq[string] = @[]
  var current = ""
  var inQuotes = false
  var i = 0
  
  while i < line.len:
    let c = line[i]
    if c == '"':
      if inQuotes and i + 1 < line.len and line[i + 1] == '"':
        current.add('"')
        i += 2
      else:
        inQuotes = not inQuotes
        i += 1
    elif c == ',' and not inQuotes:
      result.add(current)
      current = ""
      i += 1
    else:
      current.add(c)
      i += 1
  
  result.add(current)
  return result

let file = open("sentences.csv", fmRead)
for line in file.lines:
  let fields = parseCsvLine(line)
  if fields.len >= 4:
    let original = fields[0]
    let translation = fields[1]
    let audioPath = fields[3]
    sentences.add((original: original, translation: translation, audioPath: audioPath))
    #echo "Loaded: ", original, " | Audio: ", audioPath

file.close()

var currentIndex = 0
var rangeStart = 1
var rangeEnd = sentences.len

var window = newWindow("Danish Flashcards")
window.width = 500
window.height = 150

var label = newLabel(if sentences.len > 0: sentences[0].original else: "No data")
label.fontSize = 24

var meaningButton = newButton("Meaning")
var nextButton = newButton("Next")
var rangeStartBox = newTextBox($rangeStart)
var rangeEndBox = newTextBox($rangeEnd)
var applyRangeButton = newButton("Apply Range")

var container = newLayoutContainer(Layout_Vertical)
container.xAlign = XAlign_Center
container.yAlign = YAlign_Center

var rangeContainer = newLayoutContainer(Layout_Horizontal)
rangeContainer.add(newLabel("From:"))
rangeContainer.add(rangeStartBox)
rangeContainer.add(newLabel("To:"))
rangeContainer.add(rangeEndBox)
rangeContainer.add(applyRangeButton)

var buttonContainer = newLayoutContainer(Layout_Horizontal)
buttonContainer.add(meaningButton)
buttonContainer.add(nextButton)

container.add(label)
container.add(buttonContainer)
container.add(rangeContainer)

window.add(container)

proc playAudio(path: string) =
  #echo "Playing: ", path
  let cmd = "paplay " & quoteShell(path)
  discard execCmd(cmd)

proc updateDisplay() =
  if currentIndex >= rangeStart-1 and currentIndex < rangeEnd:
    label.text = sentences[currentIndex].original
  else:
    currentIndex = rangeStart-1
    label.text = sentences[currentIndex].original

label.onClick = proc(event: ClickEvent) =
  if currentIndex < sentences.len:
    playAudio(sentences[currentIndex].audioPath)

meaningButton.onClick = proc(event: ClickEvent) =
  if currentIndex < sentences.len:
    window.alert(sentences[currentIndex].translation)

nextButton.onClick = proc(event: ClickEvent) =
  currentIndex += 1
  if currentIndex >= rangeEnd or currentIndex >= sentences.len:
    currentIndex = rangeStart-1
  updateDisplay()

applyRangeButton.onClick = proc(event: ClickEvent) =
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

if sentences.len > 0:
  playAudio(sentences[0].audioPath)

window.show()
app.run()
