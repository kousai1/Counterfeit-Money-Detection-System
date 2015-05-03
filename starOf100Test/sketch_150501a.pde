import gab.opencv.*;
import org.opencv.imgproc.Imgproc;
import org.opencv.core.Core;
import org.opencv.highgui.Highgui;
import org.opencv.core.Mat;
import org.opencv.core.MatOfPoint;
import org.opencv.core.MatOfPoint2f;
import org.opencv.core.MatOfPoint2f;
import org.opencv.core.CvType;
import org.opencv.core.Point;
import org.opencv.core.Size;
import org.opencv.core.Core.MinMaxLocResult;
PImage imgBack, rightSection, leftSection;
PImage img;

void setup(){
  imgBack=loadImage("tk100backback.jpg");
  leftSection=imgBack.get(0,0,14,200);
  rightSection=imgBack.get(438,0,32,200);
  img=createImage(46,200,RGB);
  img.set(0,0,rightSection);
  img.set(32,0,leftSection);
  size(46,200);
  Mat src= Highgui.imread(img.toString());
  Mat tmp=Highgui.imread("templateStarMatching.jpg");
  int result_cols=src.cols()-tmp.cols()+1;
  int result_rows=src.rows()-tmp.rows()+1;
  Mat result = new Mat(result_rows, result_cols, CvType.CV_32FC1);
  Imgproc.matchTemplate(src, tmp, result, Imgproc.TM_CCOEFF_NORMED);
  
  MatOfPoint minLoc = new MatOfPoint();
  MatOfPoint maxLoc = new MatOfPoint();
  MinMaxLocResult mrec=new MinMaxLocResult();
  mrec=Core.minMaxLoc(result,null);
 
  System.out.println(mrec.minVal);
  System.out.println(mrec.maxVal);
    
  Point point = new Point(mrec.maxLoc.x+tmp.width(), mrec.maxLoc.y+tmp.height());
 // cvRectangle(src, maxLoc, point, CvScalar.WHITE, 2, 8, 0);//Draw a Rectangle for Matched Region
    
}
void draw(){
  image(img,0,0);
}
