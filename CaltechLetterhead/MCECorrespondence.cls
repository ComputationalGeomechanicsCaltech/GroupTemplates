%------------------------------------------------------%
%                      Identifiers                     %
%------------------------------------------------------%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{MCECorrespondence}[2015/08/03  Caltech MCE Letter and Memo Class]

%------------------------------------------------------%
%                   Revision History                   %
%------------------------------------------------------%

%  The hssletter style dates back to at least 1989, 
%  and hssmemo was around in 1990. The new 
%  Caltech Identity project prompted me to review them.
%  Both were extensions of the LaTeX letter class, and 
%  I came to the conclusion that they overlap so much, 
%  they should be combined into a single class.

%  Instead of loading letter.cls and redefining half 
%  of it, I just took the parts we'll use.  For 
%  instance, I omitted the LaTeX 2.09 compatibility 
%  code, and I omitted the label making code.  
%  This also means we'll miss out any new bells and 
%  whistles in future updates to letter.cls.  

%  The new class reflects my own prejudices.  
%  The days of Barbara Yandell laying down the law  
%  on style are long gone.  
%  Besides, Federico and I may be the only people
%  to use this class and now Jason in MCE!

%  ---kcb@hss

%  2015.05.15  Beta 0.5
%  2015.05.21  Beta 0.6
%            Added \ndash command.
%            Fixed persistence in optional args for
%            graphic signatures.
%            To no longer appears in header if there
%            is no \To command.
%  2015-05-22  Beta 0.7
%            Really fixed persistence in optional args.
%            Changed default font to Times for memo,
%            Garamond for letter.
%            Added option to freeze space above date.
%  2015-06-10  Beta 0.7.1
%            Redefined \isodate using existing command
%            \two@digits
%            Changed the Division font to 12/14 from 13/15.
%            I may change it back.
%            Really minor namespace changes.

%------------------------------------------------------%
%                   Required packages                  %
%------------------------------------------------------%
\RequirePackage{graphicx}
\RequirePackage{color}

\RequirePackage{ifthen}
\RequirePackage{keyval}


%------------------------------------------------------%
%                Declaration of Options                %
%------------------------------------------------------%
% Basic options stolen from letter.cls
% Paper size
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}}
\DeclareOption{a5paper}
   {\setlength\paperheight {210mm}%
    \setlength\paperwidth  {148mm}}
\DeclareOption{b5paper}
   {\setlength\paperheight {250mm}%
    \setlength\paperwidth  {176mm}}
\DeclareOption{letterpaper}
   {\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{legalpaper}
   {\setlength\paperheight {14in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{executivepaper}
   {\setlength\paperheight {10.5in}%
    \setlength\paperwidth  {7.25in}}
\DeclareOption{landscape}
   {\setlength\@tempdima   {\paperheight}%
    \setlength\paperheight {\paperwidth}%
    \setlength\paperwidth  {\@tempdima}}
% Font size
\DeclareOption{10pt}{\def\@ptsize{0}}
\DeclareOption{11pt}{\def\@ptsize{1}}
\DeclareOption{12pt}{\def\@ptsize{2}}
% Miscellaneous
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
%------------------------------------------------------%
%  HSS:

% Control Locations for Mail Code:
\newboolean{baxter}
\DeclareOption{baxter}{\setboolean{baxter}{true}}
\DeclareOption{Baxter}{\setboolean{baxter}{true}}

\newboolean{dabney}
\DeclareOption{dabney}{\setboolean{dabney}{true}}
\DeclareOption{Dabney}{\setboolean{dabney}{true}}

% Eschew color:
\newboolean{bw}
\DeclareOption{bw}{\setboolean{bw}{true}}

% Create auxiliary file
\newboolean{files}
\DeclareOption{files}{\setboolean{files}{true}}

% Suppress second page header
\newboolean{noheader}
\DeclareOption{noheader}{\setboolean{noheader}{true}}

% "Watermark" the first page.
\newboolean{watermark}
\setboolean{watermark}{true}
\DeclareOption{watermark}{\setboolean{watermark}{true}}
\DeclareOption{nowatermark}{\setboolean{watermark}{false}}

% Input uses – endash character
\newboolean{ndash}
\setboolean{ndash}{true}

% Use Latin Modern Fonts
\newboolean{allfonts}
\setboolean{allfonts}{true}

\newboolean{texfonts}
\DeclareOption{texfonts}{\setboolean{texfonts}{true}
\setboolean{allfonts}{false}}

\newboolean{nofontspec}
\DeclareOption{nofontspec}{\setboolean{nofontspec}{true}
\setboolean{allfonts}{false}
\setboolean{ndash}{false}
}

% Wider text, narrower margins
\newboolean{widetext}
\DeclareOption{widetext}{\setboolean{widetext}{true}}

% By default, the space between the return address and 
% the date is stretchy,  so for a very short letter, 
% the whole thing moves down a bit from the return address.  
% Sabrina doesn't like this, so this option suppresses it.
\newboolean{nostretch}
\DeclareOption{nostretch}{\setboolean{nostretch}{true}}


% Warn about useless options
\DeclareOption{oneside}{\typeout{^^J ** The oneside option is ignored by MCECorrespondence. **}}
\DeclareOption{twoside}{\typeout{^^J ** The twoside option is ignored by MCECorrespondence. **}}

%------------------------------------------------------%

\ExecuteOptions{letterpaper,12pt,final}
\ProcessOptions

%------------------------------------------------------%
%       Set dimensions according to ptsize option      %
%------------------------------------------------------%

\input{size1\@ptsize.clo}

\ifthenelse{\boolean{widetext}}
{\addtolength{\textwidth}{1in}}
{\relax}


%------------------------------------------------------%
%                    Auxiliary files                   %%------------------------------------------------------%

\ifthenelse{\boolean{files}}{\relax}{\nofiles}


%------------------------------------------------------%
%                         Fonts                        %
%------------------------------------------------------%
\ifthenelse{\boolean{nofontspec}}
{
\usepackage[T1]{fontenc}
\usepackage{lmodern}
\newcommand{\DivisionFont}{\fontfamily{lmss}\fontseries{m}\fontshape{n}\fontsize{13}{15}\selectfont}
\newcommand{\ReturnFont}{\fontfamily{lmss}\fontseries{m}\fontshape{n}\selectfont}
\newcommand{\LabelFont}{\fontfamily{lmss}\fontseries{m}\fontshape{n}\selectfont}
}
{\RequirePackage{fontspec}
\ifthenelse{\boolean{texfonts}}
{
\setmainfont{Latin Modern Roman}
\newfontface\DivisionFont{Latin Modern Sans}
\newfontface\ReturnFont{Latin Modern Sans}
\newfontface\LabelFont{Latin Modern Sans}
}
{
\newfontface\DivisionFont{TeX Gyre Heros}
\newfontface\ReturnFont{TeX Gyre Heros}
\newfontface\LabelFont{TeX Gyre Heros}
}
}

% Shortcut
\newcommand{\lfont}{\fontsize{9}{11}\LabelFont}

% Some fonts don't like -- and some don't like –
% This has to be declared robust, 
% because the memo header moves it around in mail codes.
\DeclareRobustCommand{\ndash}{\ifthenelse{\boolean{ndash}}
{–}{--}}

%------------------------------------------------------%
%                      Page layout                     %
%------------------------------------------------------%
% A bp is a printer's or PostScript point, 1/72 inch.
% A pt is 1/72.3 inch.

%  From letter.cls
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength\parskip{0.7em}
\setlength\parindent{0\p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
  \setlength\@tempdima{\paperwidth}
  \addtolength\@tempdima{-2in}
  \addtolength\@tempdima{-\textwidth}
  \setlength\oddsidemargin   {.5\@tempdima}
  \setlength\evensidemargin  {\oddsidemargin}
  \setlength\marginparwidth  {90\p@}
\setlength\marginparsep {11\p@}
\setlength\marginparpush{5\p@}
\setlength{\skip\footins}{10\p@ \@plus 2\p@ \@minus 4\p@}
\medskipamount=\parskip

\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}


%------------------------------------------------------%
%  HSS:
\setlength{\topmargin}{-8bp}
\setlength{\headheight}{24bp} 
\setlength{\headsep}{24bp}
\setlength{\footskip}{18bp}

\setlength{\textheight}{\paperheight}
\addtolength{\textheight}{-96bp}
\addtolength{\textheight}{-\topmargin}
\addtolength{\textheight}{-\headheight}
\addtolength{\textheight}{-\headsep}
\addtolength{\textheight}{-\footskip}

\setlength{\parindent}{0pt}
\setlength{\parskip}{\baselineskip}

%	Separate Division from Logo
\newlength{\logosep}
\setlength{\logosep}{12pt}

%	For the letter 1st page:
\newlength{\watermarkdrop}
\setlength{\watermarkdrop}{5.5in}

% For letter closing:
\newlength{\signatureheight}
\setlength{\signatureheight}{36bp}

%------------------------------------------------------%
%                                                      %
%                      Page Styles                     %
%                                                      %
%------------------------------------------------------%



%------------------------------------------------------%
%                        Page 1                        %
%------------------------------------------------------%
%  The first-page header uses the Caltech logo, and the 
%  division name.  The logo is only 21.865 pt high. The
%  two-line division name at 12/14 makes it a hair taller.
%  I think it looks fine.

\def\ps@firstpage{%
%	Header
\def\@oddhead{%
\hbox to \textwidth{\insertwatermark%
\CITlogo\hskip\logosep\hbox to \z@{\vbox{\fontsize{12}{14}\DivisionFont\@division}\hss}\hfil}%
}%  End \@oddhead 
\def\@evenhead{}
%	Footers
\ifthenelse{\boolean{letter}}
{\def\@oddfoot{\fontsize{9}{11}\ReturnFont\hfil\@fpfooter\hfil}}
{\def\@oddfoot{}}

\def\@evenfoot{\@oddfoot}
}



%------------------------------------------------------%
%           Subsequent page styles & headers           %
%------------------------------------------------------%
% Don't put To in header unless there is an addressee
\newcommand*{\@tohead}{\ifthenelse{\equal{\@toname}{\ignorespaces}}
{\null}
{\headtoname\ \@toname}}


\ifthenelse{\boolean{noheader}}
{\def\ps@headings{%
\let\@oddhead\@empty
\let\@oddfoot\@empty
}}
%
{\def\ps@headings{%
\let\@oddfoot\@empty
\def\@oddhead{%
\vbox to \headheight{\vfill
\hbox to \textwidth {\small\@tohead\hfil\pagename{} \thepage}
\vspace{1bp}
\textcolor{ob}{\hrulefill}
\vss}}
}}





%------------------------------------------------------%
%                                                      %
%                   Internal commands                  %
%                                                      %
%------------------------------------------------------%
%  From letter.cls
% Line control to keep page breaks out of paragraphs
\newcommand*{\stopbreaks}{%
  \interlinepenalty\@M
  \def\par{\@@par\nobreak}%
  \let\\\@nobreakcr
  \let\vspace\@nobreakvspace}
  
\DeclareRobustCommand\@nobreakvspace
   {\@ifstar\@nobreakvspacex\@nobreakvspacex}
   
\def\@nobreakvspacex#1{%
  \ifvmode
    \nobreak\vskip #1\relax
  \else
    \@bsphack\vadjust{\nobreak\vskip #1}\@esphack
  \fi}
  
\def\@nobreakcr{\@ifstar{\@normalcr*}{\@normalcr*}}

\newcommand*{\startbreaks}{%
  \let\\\@normalcr
  \interlinepenalty 200%
  \def\par{\@@par\penalty 200\relax}}

% Labels
\newcommand*{\ccname}{cc}
\newcommand*{\enclname}{encl}
\newcommand*{\pagename}{}
\newcommand*{\headtoname}{To}

\newcommand*{\today}{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
  
%------------------------------------------------------%
% HSS
\newboolean{letter}
\newboolean{memo}
\newboolean{sigfile}

% Common empty containers:
\newcommand{\@division}{}
\newcommand{\@email}{}
\newcommand{\@from}{}
\newcommand{\@mailcode}{}
\newcommand{\@phone}{}
\newcommand{\@sigfile}{}
\newcommand{\@to}{}
\newcommand{\@toname}{}
\newcommand{\@toaddress}{}
\newcommand{\@fromname}{}
\newcommand{\@fromaddress}{}

% Empty containers for letters:
\newcommand{\@closing}{}
\newcommand{\@fpfooter}{}
\newcommand{\@jobtitle}{}
\newcommand{\@returnaddress}{}
\newcommand{\@salute}{}
\newcommand{\@watermark}{}

% Empty containers for memos:
\newcommand{\@subject}{}


%------------------------------------------------------%
%                  Process multilines:                 %
%------------------------------------------------------%
\long\def\@processTo#1{%
  \def\@to{\ignorespaces #1}
  \@xproc #1\\@@@%
  \ifx\@toaddress\@empty
  \else
    \@yproc #1@@@%
  \fi}
\long\def\@xproc #1\\#2@@@{\def\@toname{#1}\def\@toaddress{#2}}
\long\def\@yproc #1\\#2@@@{\def\@toaddress{#2}}


\def\@processFrom#1{%
  \def\@from{\ignorespaces #1}
  \@xxproc #1\\@@@%
  \ifx\@fromaddress\@empty
  \else
    \@yyproc #1@@@%
  \fi}
\def\@xxproc #1\\#2@@@{\def\@fromname{#1}\def\@fromaddress{#2}}
\def\@yyproc #1\\#2@@@{\def\@fromaddress{#2}}

% Note.  We never use \@fromaddress


%------------------------------------------------------%
%       Command to check for missing information:      %
%------------------------------------------------------%
\newcommand{\checkinfo}[1]{\expandafter\ifx\csname @#1\endcsname\@empty \@@warning{Missing #1 information}\fi}


%------------------------------------------------------%
%      Set watermark & colors according to options     %
%------------------------------------------------------%

\newcommand{\insertwatermark}{\ifthenelse{\boolean{watermark}}
{\hbox to 0bp{\raisebox{-\watermarkdrop}{\hbox to \textwidth {\hfill\makebox(0,0){\includegraphics{\@watermark}}\hfill}}\hss}}
{\null}}

%  The pdf logos are 4.96 × 1.2 inches, a ratio of 3.968,
%  which is exasperatingly close to 4.000, but isn't;
%  so I rescale them to 1.25 x 0.30249 inches 
%  or 90 x 21.7742 bp
\ifthenelse{\boolean{bw}}
{
\newcommand{\CITlogo}{\hbox to 1.25in{\resizebox{1.25in}{!}{\includegraphics{CaltechLogoBlack}}}}
\definecolor{ob}{rgb}{0,0,0}
}
{
\newcommand{\CITlogo}{\resizebox{1.25in}{!}{\includegraphics{CaltechLogoOrange}}}
\definecolor{ob}{rgb}{1.0,0.431373,0.117647} % CIT Orange
}

%------------------------------------------------------%
%                                                      %
%            New user commands and defaults            %
%                                                      %
%------------------------------------------------------%
%  From letter.cls

\newcommand*{\cc}[1]{%
  \par\noindent
  \parbox[t]{\textwidth}{%
    \@hangfrom{\normalfont\ccname: }%
    \ignorespaces #1\strut}\par}
    
\newcommand*{\encl}[1]{%
  \par\noindent
  \parbox[t]{\textwidth}{%
    \@hangfrom{\normalfont\enclname: }%
    \ignorespaces #1\strut}\par}
    
\newcommand*{\ps}{\par\startbreaks}

%------------------------------------------------------%

%  Fill those empty containers:
\newcommand*{\Closing}[1]{\renewcommand{\@closing}{#1}}
\newcommand*{\Email}[1]{\renewcommand{\@email}{#1}}
\newcommand*{\Ext}[1]{\def\@phone{#1}}
\newcommand*{\Footer}[1]{\def\@fpfooter{#1}}
\newcommand*{\From}[1]{\@processFrom{\ignorespaces #1}}
\newcommand*{\MailCode}[1]{\renewcommand{\@mailcode}{#1}}
\newcommand*{\Salutation}[1]{\def\@salute{#1}}
\newcommand*{\Signature}[1]{\def\fromsig{#1}}
\newcommand*{\Subject}[1]{\renewcommand{\@subject}{#1}}
\newcommand*{\Telephone}[1]{\def\@phone{#1}}
\newcommand*{\Title}[1]{\renewcommand{\@jobtitle}{#1}}
\newcommand*{\To}[1]{\@processTo{\ignorespaces #1}}
% N.B. Empty \To{} sets \@toname to \ignorespaces, not {}


%------------------------------------------------------%
%                    Set or override                   %
%------------------------------------------------------%
% For consistency with upper case scheme
\let\Date\date

% Return address box
\newcommand*{\ReturnAddress}[1]{\renewcommand{\@returnaddress}{\ignorespaces #1}}

% Watermark file and position
%  Optional argument allows for odd paper size
\newcommand{\Watermark}[2][0bp]{\renewcommand{\@watermark}{#2}\addtolength{\watermarkdrop}{#1}}


%  Division name in header
\newcommand{\Division}[1]{\renewcommand{\@division}{\ignorespaces #1}}


%------------------------------------------------------%
%             Deal with graphic signatures:            %
%------------------------------------------------------%
% I don't know if this is useful or not:
\newcommand{\optscalefile}[2]{\ifthenelse{\equal{#1}{1}}
{\includegraphics{#2}}
{\scalebox{#1}{\includegraphics{#2}}}
}

% There was an exotic bug in the first two versions.  
% If letters and memos are intermingled in the same file, 
% the \ESign optional arguments would overwrite the 
% \SignatureFile optional arguments.
% To avoid that remote possibility, I introduced separate
% sets of parameters.  2015-05-22

\newlength{\sigraise}
\newlength{\sigshift}
\newlength{\initraise}
\newlength{\initshift}


% We need to reset these values before each use.
% If a file has more than one memo or letter, the
% most recent values are used, 
% which may not be what we want.
\newcommand*{\reset@sigloc}{%
\setlength{\sigraise}{\z@}
\setlength{\sigshift}{\z@}
\def\sigscale{1}
}
\newcommand*{\reset@initloc}{%
\setlength{\initraise}{\z@}
\setlength{\initshift}{\z@}
\def\initscale{1}
}


% See the keyval.sty documentation:
\define@key{sigloc}{up}{\setlength{\sigraise}{#1}}
\define@key{sigloc}{right}{\setlength{\sigshift}{#1}}
\define@key{sigloc}{scale}{\def\sigscale{#1}}
\define@key{initloc}{up}{\setlength{\initraise}{#1}}
\define@key{initloc}{right}{\setlength{\initshift}{#1}}
\define@key{initloc}{scale}{\def\initscale{#1}}


\def\SignatureFile{\reset@sigloc\@ifnextchar[\@SignatureFile{\SignatureFile[]}}
\def\@SignatureFile[#1]#2{\setkeys{sigloc}{#1}\renewcommand{\@sigfile}{#2}\setboolean{sigfile}{true}}

\def\ESign{\reset@initloc\@ifnextchar[\@ESign{\ESign[]}}
\def\@ESign[#1]#2{\leavevmode\setkeys{initloc}{#1}\kern\initshift\raisebox{\initraise}{\smash{\optscalefile{\initscale}{#2}}}}



%------------------------------------------------------%
%          Define a distribution list command:         %
%------------------------------------------------------%
\newcommand{\distribution}[1]{\par\noindent
\begin{minipage}[t]{\textwidth}
\begin{tabular}{llll}{\lfont Distribution:}\\#1\end{tabular}\end{minipage}}

%------------------------------------------------------%
%             Commands for numerical date:             %
%------------------------------------------------------%
% M-D-YY:
\newcommand{\numdate}{\advance\year -2000\renewcommand{\today}{\number\month\ndash\number\day\ndash\number\year}}

% YYYY-MM-DD
\newcommand{\isodate}{\renewcommand{\today}{\number\year-\two@digits{\month}-\two@digits{\day}}}


%------------------------------------------------------%
%                      Set Defaults                    %
%------------------------------------------------------%
% Spacer between address parts in footer
\newcommand{\f@s}{\hspace{6pt}\textcolor{ob}{$\diamond$}\hspace{6pt}}

\Division{Department of Mechanical\\and Civil Engineering}

\Footer{1200 E. California Blvd.\f@s{}MC \@mailcode\f@s{}Pasadena, CA 91125}

\ReturnAddress{%
\ifthenelse{\equal{\@fromname}{}}{}{\@fromname\\}
\ifthenelse{\equal{\@jobtitle}{}}{}{\@jobtitle\\}
\ifthenelse{\equal{\@phone}{}}{}{\@phone\\}
\ifthenelse{\equal{\@email}{}}{}{\@email\\}
}

\Watermark{watermark} 

% Set mail code according to options
\ifthenelse{\boolean{dabney}}
{\MailCode{104\ndash44}}
{\MailCode{104\ndash44}}


%------------------------------------------------------%
%               Disable obsolete commands              %
%------------------------------------------------------%

\newcommand{\closing}{\typeout{^^J ** The closing command is not used with MCECorrespondence. **}}

\newcommand{\opening}{\typeout{^^J ** The opening command is not used with MCECorrespondence. **}}


%------------------------------------------------------%
%                                                      %
%          New Environments for Letter and Memo        %
%                                                      %
%------------------------------------------------------%

%------------------------------------------------------%
%                   Memo environment                   %
%------------------------------------------------------%
\newlength{\subjlen}
\newlength{\titlelen}
\newlength{\fromlen}
\newlength{\tolen}
\newlength{\maillen}
\newlength{\emaillen}
\newlength{\datelen}
\newlength{\extlen}

\newenvironment{memo}{%
\ifthenelse{\boolean{allfonts}}{\setmainfont{Times}}{\relax}
\newpage
\setcounter{page}{1}
\setboolean{memo}{true}
\setboolean{letter}{false}
\setboolean{watermark}{false}
\interlinepenalty=200 % smaller than the TeXbook value
%
%  Nitpicking measurements
\settowidth{\subjlen}{\lfont SUBJECT}
%
\setlength{\titlelen}{\textwidth}
\addtolength{\titlelen}{-\subjlen}
\addtolength{\titlelen}{-2\tabcolsep}
%
\setlength{\fromlen}{\textwidth}
%
\setlength{\tolen}{\textwidth}
%
%
% measurements:
\settowidth{\maillen}{{\lfont MAIL CODE }\@mailcode}
\settowidth{\emaillen}{{\lfont E-MAIL }\@email}
\settowidth{\datelen}{{\lfont DATE }\@date}
\settowidth{\extlen}{{\lfont EXT }\@phone}
%
\ifdim\datelen<\maillen\setlength{\datelen}{\maillen}\else\relax\fi
%
\ifdim\datelen<\extlen\setlength{\datelen}{\extlen}\else\relax\fi
%
\ifdim\datelen<\emaillen\setlength{\datelen}{\emaillen}\else\relax\fi
%
\addtolength{\datelen}{1em}
\addtolength{\fromlen}{-\subjlen}
\addtolength{\fromlen}{-\datelen}
\addtolength{\fromlen}{-6\tabcolsep}
\addtolength{\tolen}{-\subjlen}
\addtolength{\tolen}{-\datelen}
\addtolength{\tolen}{-4\tabcolsep}
%
%  check for missing information:
\checkinfo{to}
\checkinfo{from}
\checkinfo{subject}
\checkinfo{phone}
\checkinfo{mailcode}
\checkinfo{email}
%
\renewcommand{\@fpfooter}{}
% Memo Heading:
\thispagestyle{firstpage}
\vspace{24pt}
\begin{tabular*}{\textwidth}%
{@{}p{\subjlen}l@{\extracolsep{\fill}}p{\datelen}@{}}
{\lfont TO}&\begin{minipage}[t]{\tolen}\@to\end{minipage}
&{\lfont DATE }\hfill\@date
\end{tabular*}
\par\noindent
\begin{tabular*}{\textwidth}%
{@{}p{\subjlen}l@{\extracolsep{\fill}}@{\hspace{2\tabcolsep}}p{\datelen}@{}}
{\lfont FROM}&\begin{minipage}[t]{\fromlen}\@from\end{minipage}
&\begin{minipage}[t]{\datelen}
\ifthenelse{\equal{\@email}{}}{\relax}{{\lfont E-MAIL }\hfill\@email\\}
\ifthenelse{\equal{\@mailcode}{}}{\relax}{{\lfont MAIL CODE }\hfill\@mailcode\\}
\ifthenelse{\equal{\@phone}{}}{\relax}{{\lfont EXT }\hfill\@phone}
\end{minipage}
\end{tabular*}
\par\noindent
\begin{tabular*}{\textwidth}%
{@{}p{\subjlen}l@{}}
{\lfont SUBJECT}&\begin{minipage}[t]{\titlelen}\@subject\end{minipage}
\end{tabular*}
%
\medskip\par
}% \end{memo}:
{\clearpage}


%------------------------------------------------------%
%                  Letter environment                  %
%------------------------------------------------------%
\newenvironment{letter}{%
\ifthenelse{\boolean{allfonts}}{\setmainfont{EB Garamond}}{\relax}
\setboolean{letter}{true}
\setboolean{memo}{false}
\renewcommand{\ESign}[2][]{\relax}
\newpage
\setcounter{page}{1}
\setcounter{footnote}{0}
\interlinepenalty=200 % smaller than the TeXbook value
\def\fromsig{\@fromname\\\@jobtitle}
%  check for missing information:
\checkinfo{to}
\checkinfo{from}
\checkinfo{salute}
\checkinfo{closing}
\checkinfo{phone}
\checkinfo{mailcode}
\checkinfo{email}
%
\thispagestyle{firstpage}
% Return address
\parbox[t]{\textwidth}{\raggedleft
\fontsize{10}{12}\ReturnFont
\@returnaddress
}
\ifthenelse{\boolean{nostretch}}
{\vskip 12bp}
{\vskip 12bp plus .00003fil}  % based on letter.cls's \@texttop
% Date
\par\noindent
\@date
\vspace{12bp}
\par\noindent
% Addressee
\begin{tabular}{@{}l}
\@to
\end{tabular}
\vspace{12bp}
\par\noindent
\@salute
\par\nobreak
}
{
% Closing
\par\nobreak\vspace{\parskip} 
 \stopbreaks
 \noindent
 \parbox{.5\textwidth}{\raggedright
 \ignorespaces 
 \@closing\\
%  Signature
 \vskip .5\baselineskip
 \ifthenelse{\boolean{sigfile}}
 {\leavevmode\kern\sigshift \raisebox{\sigraise}{\optscalefile{\sigscale}{\@sigfile}}\\}
 {\vskip\signatureheight}
%  Printed name and title
 \fromsig
 \strut}
\@@par\pagebreak\@@par
}

%------------------------------------------------------%
%               Lists, etc from letter.cls             %
%------------------------------------------------------%
\setlength\leftmargini  {2.5em}
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\setlength\leftmarginv  {1em}
\setlength\leftmarginvi {1em}
\setlength\leftmargin    {\leftmargini}
\setlength  \labelsep  {5\p@}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\setlength\partopsep{0\p@}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\def\@listI{\setlength\leftmargin{\leftmargini}%
            \setlength\parsep {0\p@}%
            \setlength\topsep {.4em}%
            \setlength\itemsep{.4em}}
\let\@listi\@listI
\@listi
\def\@listii {\setlength  \leftmargin{\leftmarginii}%
              \setlength  \labelwidth{\leftmarginii}%
              \addtolength\labelwidth{-\labelsep}}
\def\@listiii{\setlength  \leftmargin{\leftmarginiii}%
              \setlength  \labelwidth{\leftmarginiii}%
              \addtolength\labelwidth{-\labelsep}%
              \setlength  \topsep    {.2em}%
              \setlength  \itemsep   {\topsep}}
\def\@listiv {\setlength  \leftmargin{\leftmarginiv}%
              \setlength  \labelwidth{\leftmarginiv}%
              \addtolength\labelwidth{-\labelsep}}
\def\@listv  {\setlength  \leftmargin{\leftmarginv}%
              \setlength  \labelwidth{\leftmarginv}%
              \addtolength\labelwidth{-\labelsep}}
\def\@listvi {\setlength  \leftmargin{\leftmarginvi}%
              \setlength  \labelwidth{\leftmarginvi}%
              \addtolength\labelwidth{-\labelsep}}
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*{\descriptionlabel}[1]{\hspace\labelsep
                                \normalfont\bfseries #1}
\newenvironment{verse}
               {\let\\=\@centercr
                \list{}{\setlength\itemsep{\z@}%
                        \setlength\itemindent{-15\p@}%
                        \setlength\listparindent{\itemindent}%
                        \setlength\rightmargin{\leftmargin}%
                        \addtolength\leftmargin{15\p@}}%
                \item[]}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\setlength\listparindent{1.5em}%
                        \setlength\itemindent{\listparindent}%
                        \setlength\rightmargin{\leftmargin}}%
                \item[]}
               {\endlist}
\newenvironment{quote}
               {\list{}{\setlength\rightmargin{\leftmargin}}%
                \item[]}
               {\endlist}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\renewcommand\theequation{\@arabic\c@equation}

%\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
%\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
%\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
%\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
%\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
%\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\relax}
%\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\relax}
%\DeclareRobustCommand*{\cal}{\@fontswitch{\relax}{\mathcal}}
%\DeclareRobustCommand*{\mit}{\@fontswitch{\relax}{\mathnormal}}

\renewcommand\footnoterule{%
  \kern-\p@
  \hrule \@width .4\columnwidth
  \kern .6\p@}
  
\long\def\@makefntext#1{%
    \noindent
    \hangindent 5\p@
    \hb@xt@5\p@{\hss\@makefnmark}#1}


%------------------------------------------------------%
%------------------------------------------------------%
%                                                      %
%            Add back some article commands            %
%              (we write strange letters)              %
%                                                      %
%------------------------------------------------------%
%------------------------------------------------------%


%------------------------------------------------------%
%                    Section command                   %
%------------------------------------------------------%

\newcommand\section{\@startsection {section}{1}{\z@}%
{-0.1ex \@plus -.5ex \@minus -.2ex}%
{0.01ex \@plus.2ex}%
{\bfseries}}



%------------------------------------------------------%
%                        Tables                        %
%------------------------------------------------------%

\newcounter{table}
\newcommand\tablename{Table}
\renewcommand\thetable{\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename\nobreakspace\thetable}
\newenvironment{table}
               {\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1: #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1: #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}


%------------------------------------------------------%
%                     Bibliography                     %
%------------------------------------------------------%
\let\@openbib@code\@empty
\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\newcommand{\refname}{References}

\newenvironment{thebibliography}[1]
     {{\textbf\refname}%
      \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
      
%------------------------------------------------------%

\pagenumbering{arabic}
\pagestyle{headings}
\raggedbottom

\onecolumn

\endinput
