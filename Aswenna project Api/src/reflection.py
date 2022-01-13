import os
import numpy as np
import cv2
import matplotlib.pyplot as plt

for k in range(10):
    path = "D:/test/" + str(k)+"/"
    images= os.listdir(path)
    i = 0
    print(k)
    for w in range(len(images)):
        try:
            imge_path = path+images[w]
            img = cv2.imread(imge_path)
            img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
            rows, cols, dim = img.shape
            M = np.float32([[-1, 0, cols],
                             [ 0, 1, 0   ],
                             [ 0, 0, 1   ]])
            reflected_img = cv2.warpPerspective(img,M,(int(cols),int(rows)))
            plt.imsave(path + "y"+ str(i)+".jpg", reflected_img)
            i=i+1

            N = np.float32([[1,  0, 0   ],
                            [0, -1, rows],
                            [0,  0, 1   ]])
            reflected_img2 = cv2.warpPerspective(img,N,(int(cols),int(rows)))
            plt.imsave(path +"x"+ str(i)+".jpg", reflected_img2)
            i = i + 1

            P = np.float32([[-1,  0, cols   ],
                            [0, -1, rows],
                            [0,  0, 1   ]])
            reflected_img3 = cv2.warpPerspective(img,P,(int(cols),int(rows)))
            plt.imsave(path + "xy"+ str(i)+".jpg", reflected_img3)
            i = i + 1
        except:
            print("image loard error..."+imge_path)




