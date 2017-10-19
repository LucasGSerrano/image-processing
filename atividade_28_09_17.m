%% Ler imagem
img = imread('sunset3.bmp');
figure,imshow(img);title('Sunset');
%% Parte 1
img_fourrier_1 = fft(img,[],1);
img_fourrier = fft(img_fourrier_1,[],2);

img_fourrier_gain = log(1+1e-3*abs(img_fourrier));
img_transf = abs(fftshift(img_fourrier_gain))/max(max(img_fourrier_gain));
imshow(img_transf);

img_inverse = ifft2(img_fourrier);
imagesc(min(min(img_inverse)),max(max(img_inverse)),abs(img_inverse));
colormap(gray);
%% Parte 2
img_size = size(img);

gray_median = sum(sum(img))/(img_size(1)*img_size(2));

abs_img_fourrier = abs(img_fourrier);

gray_median_fourrier = abs_img_fourrier(1,1)/(img_size(1)*img_size(2));
% Os valores sao iguais
%% Parte 3
img_fourrier_2dim = fft2(img);

%img_fourrier_gain_2dim = log(1+1e-3*abs(img_fourrier_2dim));
%img_transf_2dim_new = abs(img_fourrier_gain_2dim)/max(max(img_fourrier_gain_2dim));
%figure,imagesc(img_transf_2dim_new),title('Fourrier');
%colormap(gray);

img_fourrier_2dim(9,19) = 0.0;
img_fourrier_2dim(249,239) = 0.0;
%figure,imagesc(img_transf_2dim_new),title('Fourrier');
%colormap(gray);

img_inverse_2dim = ifft2(img_fourrier_2dim);
figure,imagesc(min(min(img_inverse_2dim)),max(max(img_inverse_2dim)),img_inverse_2dim),title('Original sem ruido');
colormap(gray);

%% Parte 4

img_make = zeros(256,256);
% subplot(2,2,1), imagesc(min(min(img_make)),max(max(img_make)),img_make),title('Made Image Original');
% colormap(gray);

img_make(119:139,119:139) = 1.0;
subplot(2,2,1), imagesc(min(min(img_make)),max(max(img_make)),img_make),title('Made Image'), axis('square');
colormap(gray);

img_make = fftshift(img_make);

img_quad = imread('quad.bmp');
img_fourrier_quad = fft2(img_quad);
img_transf_quad = abs(fftshift(img_fourrier_quad))/max(max(img_fourrier_quad));
subplot(2,2,2),imagesc(min(min(img_transf_quad)),max(max(img_transf_quad)),img_transf_quad),title('Fourrier Quad'), axis('square');
colormap(gray);

fourrier_multiplied = img_fourrier_quad .* img_make;
inverse_multiplied = ifft2(fourrier_multiplied);
subplot(2,2,3),imagesc(min(min(inverse_multiplied)),max(max(inverse_multiplied)),abs(inverse_multiplied)),title('Multiplied Inverse'), axis('square');
colormap(gray);

[start,array_size] = size(inverse_multiplied(50,:));
subplot(2,2,4),plot(1:array_size, inverse_multiplied(50,:)*255),title('Line 50'), axis('square');