#1 stuff not all here
nums <- 1:20
rev <- 19:1
double <- c(nums,rev)
print(double)
tmp <- c(4,6,3)
repeated <- rep(tmp, times= 11, length.out=31)
more <- rep(tmp, c(10, 20, 30))


#2
x = seq(3,6, by =0.1)
trig <- exp(x)*cos(x)

#3 Dont use for loops when you can
a = seq(3,36, by =3)
b = seq(1,34, by =3)
ans <- 0.1^a * 0.2^b

#4
 y <-seq(10,100)
 th <- sum(y^3+ 4 *y^2)


