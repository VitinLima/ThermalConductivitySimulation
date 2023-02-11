clear all
close all
clc

if length(argv()) > 0
  s = argv(){1};
else
  s = "-1";
endif
disp('Hello world!');
disp(s);