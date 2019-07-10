import numpy as np
import cv2
class RugPerspectivePoint:
    def find_point(img):
        imax,jmax,ch = np.shape(img)
        index = np.zeros([2,4]) + imax + jmax        
        for i in range(0,imax):
            for j in range(0,jmax):
                if img[i,j,0]==0 and img[i,j,1]==0 and img[i,j,2]==0 :
                    index[0,0] =i
                    index[1,0] = j
                    i = imax-1
                    j = jmax-1
                    break
        for j in range(0,jmax):
            for i in range(0,imax):
                if img[i,j,0]==0 and img[i,j,1]==0 and img[i,j,2]==0 :
                    index[0,1] =i
                    index[1,1] = j
                    i = imax-1
                    j = jmax-1
                    break
        for i in range(imax-1,0,-1):
            for j in range(jmax-1,0,-1):
                if img[i,j,0]==0 and img[i,j,1]==0 and img[i,j,2]==0 :
                    index[0,2] =i
                    index[1,2] = j
                    i = 1
                    j = 1
                    break
        for j in range(jmax-1,0,-1):
            for i in range(imax-1,0,-1):
                if img[i,j,0]==0 and img[i,j,1]==0 and img[i,j,2]==0 :
                    index[0,3] =i
                    index[1,3] = j
                    i = 1
                    j = 1
                    break
        return index
    def obtain_perspective(index, img):
        rows,cols,ch = img.shape
        pts1 = np.float32([[0,0],[cols,0],[0,rows],[cols,rows]])
        ctx = 6
        pts2 = np.float32([[index[1,3]-ctx,index[0,3]+ctx],[index[1,2]-ctx,index[0,2]-ctx],[index[1,0]+ctx-8,index[0,0]+ctx],[index[1,1]+ctx,index[0,1]-ctx]])
        #####################################
        pts2[3,0] = 742
        pts2[3,1] = 673
        ##################
        pts2[0,0] = -120
        pts2[0,1] = 585
        return pts1, pts2
    def map_perspective(img, imCarp, pts1, pts2):
        imax,jmax,ch = np.shape(img)
        imCarp = cv2.resize(imCarp,(jmax, imax))
        rows,cols,ch = imCarp.shape
        #M = cv2.getPerspectiveTransform(pts1,pts2)
        h, status = cv2.findHomography(pts1,pts2)
        dst = cv2.warpPerspective(imCarp,h,(int(cols),int(rows)))
        return dst