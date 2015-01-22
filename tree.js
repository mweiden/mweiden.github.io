function setup() {
  canvasSize = 750
  createCanvas(1600, canvasSize);
  background(240, 240, 240);

  segments = [
    [0.0, 0.0, 0.0, 1.0],
    [0.0, 0.35, -0.325, 0.725],
    [0.0, 0.3,  0.325,  0.675]
  ]

  recurse(placeFrame(200), segments, 1)
  recurse(placeFrame(500), segments, 2)
  recurse(placeFrame(800), segments, 4)
  recurse(placeFrame(1100), segments, 7)
  recurse(placeFrame(1400), segments, 9)
}

function placeFrame(horiz) {
  return [horiz, canvasSize - 25, canvasSize / 2, 0.0, 0.0, - (canvasSize - 50)]
}

function recurse(frame, segments, level) {
  if (level == 0) {
    return
  } else {
    painter(frame)(segments)
    nextTreeFrames(frame, segments).forEach(function(frame, i) {
      recurse(frame, segments, level - 1)
    })
  }
}

//function draw() {
//}

function rotateVec(vec, rad) {
  return [vecX(vec) * cos(rad) - vecY(vec) * sin(rad),
          vecX(vec) * sin(rad) - vecY(vec) * cos(rad)
         ]
}

function flatten(array) {
  return array.reduce(function(a, b) { return a.concat(b) })
}

function nextTreeFrames(frame, lineSegments) {
  topBranchEnd     = frameCoordMap(frame)(lineEnd(   lineSegments[0]))
  leftBranchStart  = frameCoordMap(frame)(lineStart( lineSegments[1]))
  leftBranchEnd    = frameCoordMap(frame)(lineEnd(   lineSegments[1]))
  rightBranchStart = frameCoordMap(frame)(lineStart( lineSegments[2]))
  rightBranchEnd   = frameCoordMap(frame)(lineEnd(   lineSegments[2]))

  origin = frameOrigin(frame)

  topEdge1Scale  =
    norm2(topBranchEnd, rightBranchStart) /
    norm2(origin, addVec(origin, frameEdge2(frame)))

  sideEdge1Scale =
    (norm2(leftBranchStart, leftBranchEnd) /
     norm2(origin, addVec(origin, frameEdge2(frame))))

  angle = atan(0.5)

  // 1. left
  // 2. center
  // 3. right
  return [
    [leftBranchStart,
     rotateVec(scaleVec(sideEdge1Scale, frameEdge1(frame)), -angle),
     subVec(leftBranchEnd, leftBranchStart)
    ],
    [rightBranchStart,
     scaleVec(topEdge1Scale, frameEdge1(frame)),
     subVec(topBranchEnd, rightBranchStart)
    ],
    [rightBranchStart,
     rotateVec(scaleVec(sideEdge1Scale, frameEdge1(frame)), angle),
     subVec(rightBranchEnd, rightBranchStart)
    ]
  ].map(flatten)
}

function frameCoordMap(frame) {
  return function(vec) {
    return addVec(frameOrigin(frame),
                  addVec(scaleVec(vecX(vec),
                                  frameEdge1(frame)),
                         scaleVec(vecY(vec),
                                  frameEdge2(frame))));
  }
}

function painter(frame) {
  return function(lineSegments) {
    lineSegments.forEach(function(lineSegment) {
      start = frameCoordMap(frame)(lineStart(lineSegment))
      end = frameCoordMap(frame)(lineEnd(lineSegment))
      drawLine(start, end);
    })
  }
}

function norm2(startPoint, endPoint) {
  return sqrt(pow(vecX(endPoint) - vecX(startPoint), 2.0) + pow(vecY(endPoint) - vecY(startPoint), 2.0));
}

function vecX(vec) {
  return vec[0]
}

function vecY(vec) {
  return vec[1]
}

function lineStart(line) {
  return [line[0], line[1]]
}

function lineEnd(line) {
  return [line[2], line[3]]
}

function drawLine(start, end) {
  line(start[0], start[1], end[0], end[1])
}

function frameEdge1(frame) {
  return [frame[2], frame[3]]
}
function frameEdge2(frame) {
  return [frame[4], frame[5]]
}

function frameOrigin(frame) {
  return [frame[0], frame[1]]
}

function addVec(vec1, vec2) {
  return vec1.map(function(val, ind) { return val + vec2[ind] })
}

function subVec(vec1, vec2) {
  return vec1.map(function(val, ind) { return val - vec2[ind] })
}

function scaleVec(scale, vec) {
  return vec.map(function(val) { return val * scale })
}

