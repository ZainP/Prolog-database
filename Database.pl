% the statements allows to assert facts

:- dynamic student/8.

% FACTS
% student(name, address, student ID and grades of five subjects (C, C++, VB, JAVA, PROLOG))        

% Functions & Rules
%--------------------------------------------------------------------
menu:-
	writeln('*****************************************'),
	writeln('0 - Exit program'),	
	writeln('1 - Add new student data'),
	writeln('2 - Search student by name'),
	writeln('3 - Search student by ID number'),
	writeln('4 - Show all Student data records'),
	writeln('5 - Delete student data'),	
	writeln('*****************************************'), nl.                                                  
%--------------------------------------------------------------------
main:-
	write('Enter your choice: '),
	read(Choice),
	(main_level(Choice); Choice==0, write('Thank you for using this system')).
	
%--------------------------------------------------------------------
% Exit program
main_level(0):-	
    tell('students.pl'),
	listing(student),
	told,
	nl, write('Thank you for using this programm').

%--------------------------------------------------------------------
% Adding a new student into the database
main_level(1):-
	nl, write('Please enter the name of the student: '), read(N), nl,
	write('Please enter the address of the student: '), read(A), nl, 
	write('Please enter the ID number of the student: '), read(ID), nl, 
	writeln('Please enter the five subject marks of the student'), nl,	
	
	write('C: '), read(S1), nl,
	write('C++: '), read(S2), nl, 
	write('VB: '), read(S3), nl,
	write('JAVA: '), read(S4), nl,	
	write('PROLOG: '), read(S5), nl,
	assert(student(N, A, ID, S1, S2, S3, S4, S5)),
	writeln('New entry has been successfully added.'), nl,
	menu, main.		

%--------------------------------------------------------------------
% Search by name of the student record
main_level(2):-	
	nl, write('Please enter the name of the student: '), read(N),
    findall(N,student(N,_,_,_,_,_,_,_),List),
	length(List,L), L > 0, !,
	writeln('Search results:'), nl, my_find_1(N), menu, main.
	
 main_level(2):- writeln('Oops! This entry does not exist, please try again.'), nl, menu, main.
%--------------------------------------------------------------------

% Search by ID of the student record
main_level(3):-
	nl, write('Please enter the ID number of the student: '), read(ID),
    findall(_,student(_,_,ID,_,_,_,_,_),List),
	length(List,L), L > 0, !,
	writeln('Search results:'), nl, my_find_2(ID), menu, main.
	
 main_level(3):- writeln('Oops! This entry does not exist, please try again.'), nl, menu, main.
	
%--------------------------------------------------------------------
% Display all exisitng student records 
main_level(4):-
    findall(N,student(N,_,_,_,_,_,_,_),List),
	length(List,L), L > 0, !,
	nl, writeln('Search results:'), nl, my_find_3, menu, main.
	
main_level(4):-	writeln('The database is empty, please use option 1 to add data.'),  nl, menu, main.

%--------------------------------------------------------------------
% Delete the student record
main_level(5):-
	nl, write('Please enter the name of the student: '), read(N), nl,
	write('Please enter the adress of the student: '), read(A),	nl,
	write('Please enter the ID number of the student: '), read(ID), nl,
    findall(_,student(N,A,ID,_,_,_,_,_),List),
	length(List,L), L > 0, !,
	nl, writeln('The record has been successfully deleted.'), my_delete_1(N,A,ID), menu, main.
	
 main_level(5):- writeln('This entry does not exist.'), nl, menu, main.
%--------------------------------------------------------------------
my_find_1(N):-
	student(N, A, ID, S1, S2, S3, S4, S5),
	write('Name: '), writeln(N), 
	write('Address: '), writeln(A), 
	write('ID number: '), writeln(ID),	
	write('Marks[C,C++,VB,Java,Prolog]: '), write('['), write(S1),write(','), 
	write(S2),write(','), write(S3),write(','), 
	write(S4),write(','), write(S5),writeln(']'),nl,fail.
my_find_1(_):- !.		

%--------------------------------------------------------------------
my_find_2(ID):-
	student(N, A, ID, S1, S2, S3, S4, S5),
	write('Name: '), writeln(N), 
	write('Address: '), writeln(A), 
	write('ID number: '), writeln(ID),	
	write('Marks[C,C++,VB,Java,Prolog]: '), write('['), write(S1),write(','), 
	write(S2),write(','), write(S3),write(','), 
	write(S4),write(','), write(S5),writeln(']'),nl,fail.
my_find_2(_):- !.	
%--------------------------------------------------------------------
my_find_3:-
	student(N, A, ID, S1, S2, S3, S4, S5),
	write('Name: '), writeln(N), 
	write('Address: '), writeln(A), 
	write('ID number: '), writeln(ID),	
	write('Marks[C,C++,VB,Java,Prolog]: '), write('['), write(S1),write(','), 
	write(S2),write(','), write(S3),write(','), 
	write(S4),write(','), write(S5),writeln(']'),nl,fail.
my_find_3:- !.	

%--------------------------------------------------------------------
my_delete_1(N, A, ID):- 
	retract(student(N, A, ID, _, _, _, _, _)),nl,fail.
	
my_delete_1(_, _, _):- !. 
%--------------------------------------------------------------------

start:- retractall(student(_,_,_,_,_,_,_,_)),
	consult('students.pl'),
	menu, main.	


