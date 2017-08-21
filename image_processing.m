%% Clear All
clc;
clear variables;
%% Read Image and Show It
img = imread('test-image.jpg');
figure,imshow(img);title('RGB');
%% RGB To GrayScale
img_gray = rgb2gray(img);
figure,imshow(img_gray);title('Gray');
%% Save Images to File
imwrite(img,'test.png');
imwrite(img_gray,'test-gray.png');
%% RGB To HSI
%Represent the RGB image in [0 1] range
I=double(img)/255;
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
%Hue
numi=1/2*((R-G)+(R-B));
denom=((R-G).^2+((R-B).*(G-B))).^0.5;
%To avoid divide by zero exception add a small number in the denominator
H=acosd(numi./(denom+0.000001));
%If B>G then H= 360-Theta
H(B>G)=360-H(B>G);
%Normalize to the range [0 1]
H=H/360;
%Saturation
S = 1-(3./(sum(I,3)+0.000001)).*min(I,[],3);
%Intensity
I=sum(I,3)./3;
%HSI
img_hsi=zeros(size(img));
img_hsi(:,:,1)=H;
img_hsi(:,:,2)=S;
img_hsi(:,:,3)=I;
figure,imshow(img_hsi);title('HSI');
%% HSI To RGB
%img_hsi = rgb2hsi(img);
%imshow(img_hsi);
%% RGB To HSV
img_hsv = rgb2hsv(img);
figure,imshow(img_hsv);title('HSV');
%% HSV To RGB
img_hsv_rgb = hsv2rgb(img_hsv);
figure,imshow(img_hsv_rgb);title('RGB - HSV');
%% Show all Images
subplot(2,2,1);
imshow(img);title('RGB');
subplot(2,2,2);
imshow(img_gray);title('Gray');
subplot(2,2,3);
imshow(img_hsv);title('HSV');
subplot(2,2,4);
imshow(img_hsi);title('HSI');