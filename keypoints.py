import sys
import dlib
import numpy as np
import cv2
import os

directory = sys.argv[1]
output_dir = sys.argv[2]

detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor('model.dat')

for filename in os.listdir(directory):
	if filename.endswith(".png"):
		print(filename)
		prefix = os.path.splitext(filename)[0]
		img = cv2.imread(directory + '/' + filename)

		img_resize = cv2.resize(img, (512, 512))
		gray = cv2.cvtColor(img_resize, cv2.COLOR_BGR2GRAY)
		try:
			bbox = detector(gray, 1)[0]
			points = predictor(gray, bbox)

			coords = np.zeros((68, 2), dtype=int)
			for i in range(0, 68):
				coords[i] = (points.part(i).x, points.part(i).y)

			for (x, y) in coords:
				cv2.circle(img, (x, y), 1, (0, 0, 255), -1)
			np.savetxt(output_dir + '/' + prefix + '.csv', coords, delimiter=',')
		except IndexError:
			cv2.imwrite(output_dir + '/' + prefix + '_out.jpg', img_resize)
