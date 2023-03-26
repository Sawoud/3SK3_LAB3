clc;
clear;
raw_image = imread('mandi.tif');
[width,height,depth] = size(raw_image);
R = zeros(width,height);
B = zeros(width,height);
G = zeros(width,height);
done = 0;
for i = 1:width
    for j = 1:height
        im1 = max(1,i-1);
        ip1 = min(i+1,raw_image(1)+1);
        jm1 = max(1,j-1);
        jp1 = min(j+1,raw_image(2)+1);
        if(mod(i,2) == 0 &&mod(j,2) == 0)
            R(i,j)=raw_image(i,j,1);
            G(i,j)=(raw_image(im1,j,1)+raw_image(ip1,j,1)+raw_image(i,jm1,1)+raw_image(i,jp1,1))/4;
            B(i,j)=(raw_image(im1,jm1,1)+raw_image(ip1,jm1,1)+raw_image(ip1,jp1,1)+raw_image(im1,jp1,1))/4;
        elseif(mod(i,2) == 1 &&mod(j,2) == 1)
            R(i,j)=(raw_image(im1,jm1,1)+raw_image(ip1,jm1,1)+raw_image(ip1,jp1,1)+raw_image(im1,jp1,1))/4;
            G(i,j)=(raw_image(im1,j,1)+raw_image(ip1,j,1)+raw_image(i,jm1,1)+raw_image(i,jp1,1))/4;
            B(i,j)=raw_image(i,j,1);
        else
            G(i,j)=raw_image(i,j);
            if(mod(i,2) == 0)
                R(i,j)=(raw_image(i,jm1,1)+raw_image(i,jp1,1))/2;
                B(i,j)=(raw_image(im1,j,1)+raw_image(ip1,j,1))/2;
            else
                R(i,j)=(raw_image(im1,j,1)+raw_image(ip1,j,1))/2;
                B(i,j)=(raw_image(i,jm1,1)+raw_image(i,jp1,1))/2;
            end
        end
    end
    done = done + (1/height)
end
for itirations = 1:5
    for i = 1:width
        for j = 1:height
            im1 = max(1,i-1);
            ip1 = min(i+1,raw_image(1)+1);
            jm1 = max(1,j-1);
            jp1 = min(j+1,raw_image(2)+1);
            if(mod(i,2) == 0 &&mod(j,2) == 0)
                Rp(i,j)=R(i,j,1);
                Gp(i,j)=(G(im1,j,1)+G(ip1,j,1)+G(i,jm1,1)+G(i,jp1,1))/4;
                Bp(i,j)=(B(im1,jm1,1)+B(ip1,jm1,1)+B(ip1,jp1,1)+B(im1,jp1,1))/4;
            elseif(mod(i,2) == 1 &&mod(j,2) == 1)
                Rp(i,j)=(R(im1,jm1,1)+R(ip1,jm1,1)+R(ip1,jp1,1)+R(im1,jp1,1))/4;
                Gp(i,j)=(G(im1,j,1)+G(ip1,j,1)+G(i,jm1,1)+G(i,jp1,1))/4;
                Bp(i,j)=B(i,j,1);
            else
                Gp(i,j)=raw_image(i,j);
                if(mod(i,2) == 0)
                    Rp(i,j)=(R(i,jm1,1)+R(i,jp1,1))/2;
                    Bp(i,j)=(B(im1,j,1)+B(ip1,j,1))/2;
                else
                    Rp(i,j)=(R(im1,j,1)+R(ip1,j,1))/2;
                    Bp(i,j)=(B(i,jm1,1)+B(i,jp1,1))/2;
                end
            end
        end
        done = done + (1/height)
    end
    R = Rp;
    G = Gp;
    B = Bp;
end

I(:,:,1) = R;
I(:,:,2) = G;
I(:,:,3) = B;
imshow(uint8(I),[])
