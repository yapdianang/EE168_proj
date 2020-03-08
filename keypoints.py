import sys
import dlib
import numpy as np
import cv2

img_path = sys.argv[1]
output_name = sys.argv[2]

detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor('model.dat')

img = cv2.imread(img_path)
img_resize = cv2.resize(img, (512, 512))
gray = cv2.cvtColor(img_resize, cv2.COLOR_BGR2GRAY)
'''
bbox = detector(gray, 1)[0]
points = predictor(gray, bbox)

coords = np.zeros((68, 2), dtype=int)
for i in range(0, 68):
	coords[i] = (points.part(i).x, points.part(i).y)

for (x, y) in coords:
	cv2.circle(img, (x, y), 1, (0, 0, 255), -1)
'''
cv2.imwrite(output_name + '_out.jpg', img_resize)
np.savetxt(output_name + '.csv', coords, delimiter=',')
