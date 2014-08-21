close all;
clear all;
a = [2 1];
b = [1 2];
ang = 0:0.01:27/180*pi;
xp = cos(ang);
yp = sin(ang);

angB = 0:0.01:64/180*pi;
xpB = 0.7*cos(angB);
ypB = 0.7*sin(angB);


angC = 27/180*pi:0.01:64/180*pi;
xpC = 1.3*cos(angC);
ypC = 1.3*sin(angC);


figure(1);
hold on;
plot([0,a(1)],[0,a(2)],'g');
plot([0,b(1)],[0,b(2)],'b');

plot(xp,yp,'r');
plot(xpB,ypB,'y');
plot(xpC,ypC,'m');
axis equal;
axis([0,3,0,3]);
xlabel('x');
ylabel('y');
legend('a','b','phi(a,x)','ph(b,x)','phi(a,b)');