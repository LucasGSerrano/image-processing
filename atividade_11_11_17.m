%% Parte 1
% a) Lendo a imagem
img = imread('quad.bmp');
figure,imshow(img);title('Quad')
% b) Criando a imagem do filtro com tudo zero menos o filtro sobel vertical
figure;
img_sobel_vert = zeros(256,256);
img_sobel_vert(1,1) = -1;
img_sobel_vert(2,1) = -2;
img_sobel_vert(3,1) = -1;
img_sobel_vert(1,2) = 0;
img_sobel_vert(2,2) = 0;
img_sobel_vert(3,2) = 0;
img_sobel_vert(1,3) = 1.0;
img_sobel_vert(2,3) = 2.0;
img_sobel_vert(3,3) = 1.0;
subplot(2,2,1), imagesc(min(min(img_sobel_vert)),max(max(img_sobel_vert)),img_sobel_vert),title('Image Sobel Vertical');
colormap(gray);
% c)Idem do item b com Sobel horizontal
img_sobel_hor = zeros(256,256);
img_sobel_hor(3,1) = -1;
img_sobel_hor(3,2) = -2;
img_sobel_hor(3,3) = -1;
img_sobel_hor(2,1) = 0;
img_sobel_hor(2,2) = 0;
img_sobel_hor(2,3) = 0;
img_sobel_hor(1,1) = 1.0;
img_sobel_hor(1,2) = 2.0;
img_sobel_hor(1,3) = 1.0;
subplot(2,2,2),imagesc(min(min(img_sobel_hor)),max(max(img_sobel_hor)),img_sobel_hor),title('Image Sobel Horizontal');
colormap(gray);
% d) Fourrier das imagens criadas com filtro Sobel.
fourrier_sobel_vert = fft2(img_sobel_vert);
img_fourrier_sobel_vert = abs(fftshift(fourrier_sobel_vert))/max(max(fourrier_sobel_vert));
subplot(2,2,3),imagesc(min(min(img_fourrier_sobel_vert)),max(max(img_fourrier_sobel_vert)),img_fourrier_sobel_vert),title('Fourrier Sobel Vertical');
colormap(gray);
fourrier_sobel_hor = fft2(img_sobel_hor);
img_fourrier_sobel_hor = abs(fftshift(fourrier_sobel_hor))/max(max(fourrier_sobel_hor));
subplot(2,2,4),imagesc(min(min(img_fourrier_sobel_hor)),max(max(img_fourrier_sobel_hor)),img_fourrier_sobel_hor),title('Fourrier Sobel Horizontal');
colormap(gray);
% e) Multiplicacao dos filtros ponto a ponto
compost_filter = img_fourrier_sobel_vert .* img_fourrier_sobel_hor;
% f) Visualizacao do filtro novo criado 
figure, imagesc(min(min(compost_filter)),max(max(compost_filter)),compost_filter),title('Compost Filter')
colormap(gray);
% g)Imagem filtrada pelo filtro criado
filtered_fourrier = fft2(img) .* (fourrier_sobel_hor .* fourrier_sobel_vert);
filtered = abs(ifft2(filtered_fourrier));
figure, imshow(filtered),title('Filtered Image')
% h) Mascara do filtro criado.
compost_filter_2 = fourrier_sobel_hor .* fourrier_sobel_vert;
ifft_compost_filter = ifft2(compost_filter_2);
figure, imagesc(min(min(ifft_compost_filter)),max(max(ifft_compost_filter)),ifft_compost_filter),title('Spatial Compost Filter')
colormap(gray);
%% Parte 2
ativ = imread('ativ.bmp');
subplot(2,2,1),imshow(ativ);title('Ativ')
% 1 - Filtro medio, matrix 3x3 de 1/9(0,11111)
mediam_filtered = imfilter(ativ,fspecial('average'));
subplot(2,2,2),imshow(mediam_filtered);title('Filtro Medio'); 
% 1.5 - Comparando reducao sem o filtro medio
downscale_no_filter = mediam_filtered;
downscale_no_filter(2:2:end,:,:) = [];
downscale_no_filter(:,2:2:end,:) = [];
subplot(2,2,3),imshow(downscale_no_filter);title('Imagem Final sem filtro'); 
% 2 - Imagem final apos reducao filtrada
ativ_final = mediam_filtered;
ativ_final(2:2:end,:,:) = [];
ativ_final(:,2:2:end,:) = [];
subplot(2,2,4),imshow(ativ_final);title('Imagem Final'); 
%% Parte 3
% a. trace o histograma da imagem;
I = imread('LOGO.bmp');
figure;
subplot(2,2,1),imhist(I);

% b. selecione um valor de threshold baixo, que permita separar o fundo do logotipo;
t = 70;

% c. binarize a imagem;
it = im2bw(I,t/255);
subplot(2,2,2),imshow(it);

% d. aplique um filtro passa-altas na imagem binarizada;
px = [-1 0 1;-1 0 1;-1 0 1];
icx = filter2(px,it);
py = px;
icy = filter2(py,it);
p=sqrt(icx.^2 +icy.^2);
fe=im2bw(p,t/255);


% e. apresente o módulo da imagem resultante.

module = abs(fe);
subplot(2,2,3),imshow(module);

%% Parte 4
% a. trace o histograma da imagem:
formas = imread('FORMAS.bmp');
figure;
subplot(3,3,1),imshow(formas);
subplot(3,3,2),histogram(formas);

% Cortando o circulo:
tc = 200;
formas_tc = im2bw(formas,tc/255);
subplot(3,3,3),imshow(formas_tc);


% Cortando o quadrado:
tq_1 = 140;
formas_tq_1 = im2bw(formas,tq_1/255);
% subplot(3,3,5),histogram(formas_tq_1);
tq_2 = 40;
formas_tq_2 = im2bw(formas_tq_1,tq_2/255);
formas_tq = formas_tq_2 - formas_tc;
subplot(3,3,4),imshow(formas_tq);


% Cortando o triangulo
formas_tt = im2bw(formas,0);
formas_tt = formas_tt - formas_tc - formas_tq;
subplot(3,3,5),imshow(formas_tt);


% Areas
area_tc = bwarea(formas_tc)
area_tq = bwarea(formas_tq)
area_tt = bwarea(formas_tt)

% Perimetros Segmentação por Borda

sz=size(formas_tc);
perimetro_sb_tc = 0;
for i=2:sz(1)-1
    for j=2:sz(2)-1
        if((formas_tc(i,j) == 0 && formas_tc(i-1,j) == 1) || (formas_tc(i,j) == 0 && formas_tc(i,j-1) == 1) || (formas_tc(i,j) == 0 && formas_tc(i-1,j-1) == 1) || (formas_tc(i,j) == 0 && formas_tc(i+1,j) == 1) || (formas_tc(i,j) == 0 && formas_tc(i,j+1) == 1) || (formas_tc(i,j) == 0 && formas_tc(i+1,j+1) == 1) || (formas_tc(i,j) == 0 && formas_tc(i-1,j+1) == 1) || (formas_tc(i,j) == 0 && formas_tc(i+1,j-1) == 1))
            perimetro_sb_tc = perimetro_sb_tc+1;
        end
    end
end

sz=size(formas_tq);
perimetro_sb_tq = 0;
for i=2:sz(1)-1
    for j=2:sz(2)-1
        if((formas_tq(i,j) == 0 && formas_tq(i-1,j) == 1) || (formas_tq(i,j) == 0 && formas_tq(i,j-1) == 1) || (formas_tq(i,j) == 0 && formas_tq(i-1,j-1) == 1) || (formas_tq(i,j) == 0 && formas_tq(i+1,j) == 1) || (formas_tq(i,j) == 0 && formas_tq(i,j+1) == 1) || (formas_tq(i,j) == 0 && formas_tq(i+1,j+1) == 1) || (formas_tq(i,j) == 0 && formas_tq(i-1,j+1) == 1) || (formas_tq(i,j) == 0 && formas_tq(i+1,j-1) == 1))
            perimetro_sb_tq = perimetro_sb_tq+1;
        end
    end
end

sz=size(formas_tt);
perimetro_sb_tt = 0;
for i=2:sz(1)-1
    for j=2:sz(2)-1
        if((formas_tt(i,j) == 0 && formas_tt(i-1,j) == 1) || (formas_tt(i,j) == 0 && formas_tt(i,j-1) == 1) || (formas_tt(i,j) == 0 && formas_tt(i-1,j-1) == 1) || (formas_tt(i,j) == 0 && formas_tt(i+1,j) == 1) || (formas_tt(i,j) == 0 && formas_tt(i,j+1) == 1) || (formas_tt(i,j) == 0 && formas_tt(i+1,j+1) == 1) || (formas_tt(i,j) == 0 && formas_tt(i-1,j+1) == 1) || (formas_tt(i,j) == 0 && formas_tt(i+1,j-1) == 1))
            perimetro_sb_tt = perimetro_sb_tt+1;
        end
    end
end

% Compacidade Segmentação por Borda

compacidade_sb_tc = perimetro_sb_tc ^ 2 / area_tc
compacidade_sb_tq = perimetro_sb_tq ^ 2 / area_tq
compacidade_sb_tt = perimetro_sb_tt ^ 2 / area_tt
% % Compacidade Codigo Cadeia
% 
% compacidade_cc_tc = perimetro_cc_tc ^ 2 / area_tc
% compacidade_cc_tq = perimetro_cc_tq ^ 2 / area_tq
% compacidade_cc_tt = perimetro_cc_tt ^ 2 / area_tt