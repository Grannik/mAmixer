#!/bin/bash
 E='echo -e';    # -e включить поддержку вывода Escape последовательностей
 e='echo -en';   # -n не выводить перевод строки
 trap "R;exit" 2 #
    ESC=$( $e "\e")
   TPUT(){ $e "\e[${1};${2}H" ;}
  CLEAR(){ $e "\ec";}
# 25 возможно это
  CIVIS(){ $e "\e[?25l";}
# это цвет текста списка перед курсором при значении 0 в переменной  UNMARK(){ $e "\e[0m";}
MARK(){ $e "\e[1;44m";}
# 0 это цвет списка
 UNMARK(){ $e "\e[0m";}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Эти строки задают цвет фона ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  R(){ CLEAR ;stty sane;CLEAR;};                 # в этом варианте фон прозрачный
# R(){ CLEAR ;stty sane;$e "\ec\e[37;44m\e[J";}; # в этом варианте закрашивается весь фон терминала
# R(){ CLEAR ;stty sane;$e "\ec\e[0;45m\e[";};   # в этом варианте закрашивается только фон меню
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 HEAD(){ for (( a=2; a<=41; a++ ))
  do
   TPUT $a 1
        $E "\xE2\x94\x82                                                                                \xE2\x94\x82";
  done
 TPUT 3 4
        $E "\033[1;36m amixer\033[0m";
 TPUT 4 0
        $E "\033[2m+-- микшер командной строки для драйвера звуковой карты ALSA --------------------+\033[0m";
 TPUT 12 3
        $E "\033[1;2mОпции  \033[36m                                        Options \033[0m";
 TPUT 21 3
        $E "\033[1;2mКоманды\033[36m                                        Commands\033[0m";
 TPUT 34 3
        $E "\033[1;2mРецепты\033[36m                                        Recipes \033[0m";
 TPUT 39 3
        $E "\033[2mUp \xE2\x86\x91 \xE2\x86\x93 Down Select Enter\033[0m";
 MARK;TPUT 1 1
 $E "+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+" ;UNMARK;}
   i=0; CLEAR; CIVIS;NULL=/dev/null
 FOOT(){ MARK;TPUT 42 1
 $E "+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+";UNMARK;}
# это управляет кнопками ввер/хвниз
 i=0; CLEAR; CIVIS;NULL=/dev/null
#
 ARROW(){ IFS= read -s -n1 key 2>/dev/null >&2
           if [[ $key = $ESC ]];then
              read -s -n1 key 2>/dev/null >&2;
              if [[ $key = \[ ]]; then
                 read -s -n1 key 2>/dev/null >&2;
                 if [[ $key = A ]]; then echo up;fi
                 if [[ $key = B ]];then echo dn;fi
              fi
           fi
           if [[ "$key" == "$($e \\x0A)" ]];then echo enter;fi;}
# 4 и далее это отступ сверху и 48 это расстояние слева
  M0(){ TPUT  5 3; $e " Установка                                      \033[32minstall                      \033[0m";}
  M1(){ TPUT  6 3; $e " Конфигурационные файлы                         \033[32mconf                         \033[0m";}
  M2(){ TPUT  7 3; $e " Kраткий обзор                                  \033[32mSynopsis                     \033[0m";}
  M3(){ TPUT  8 3; $e " Описание                                       \033[32mDescription                  \033[0m";}
  M4(){ TPUT  9 3; $e " Смотрите также                                 \033[32mSee Also                     \033[0m";}
  M5(){ TPUT 10 3; $e " Ошибки                                         \033[32mBugs                         \033[0m";}
  M6(){ TPUT 11 3; $e " Автор                                          \033[32mAuthor                       \033[0m";}
#
  M7(){ TPUT 13 3; $e " Cписок настроек микшера                        \033[32mamixer                       \033[0m";}
  M8(){ TPUT 14 3; $e " Выберите номер карты для управления            \033[32m-c card                      \033[0m";}
  M9(){ TPUT 15 3; $e " Выберите имя устройства для управления         \033[32m-D device                    \033[0m";}
 M10(){ TPUT 16 3; $e " Прочитайте со стандартного ввода               \033[32m-s | --stdin                 \033[0m";}
 M11(){ TPUT 17 3; $e " Справка                                        \033[32m-h                           \033[0m";}
 M12(){ TPUT 18 3; $e " Бесшумный режим                                \033[32m-q                           \033[0m";}
 M13(){ TPUT 19 3; $e " Используйте необработанное значение            \033[32m-R                           \033[0m";}
 M14(){ TPUT 20 3; $e " Используйте сопоставленный объем               \033[32m-M                           \033[0m";}
#
 M15(){ TPUT 22 3; $e " Показывает синтаксис                           \033[32m--help                       \033[0m";}
 M16(){ TPUT 23 3; $e " Показывает информацию о микшере                \033[32minfo                         \033[0m";}
 M17(){ TPUT 24 3; $e " Показывает список элементов управления микшера \033[32mscontrols                    \033[0m";}
 M18(){ TPUT 25 3; $e " Cписок управления микшера с их содержимым      \033[32mscontents                    \033[0m";}
 M19(){ TPUT 26 3; $e " Управлениe (Включить/oтключить) [mute, unmute] \033[32mset/sset<SCONTROL><PARAMETER>\033[0m";}
 M20(){ TPUT 27 3; $e "            (Уровень звука     )                \033[32mset/sset<SCONTROL><PARAMETER>\033[0m";}
 M21(){ TPUT 28 3; $e "            (Громче/тише       )                \033[32mset/sset<SCONTROL><PARAMETER>\033[0m";}
 M22(){ TPUT 29 3; $e " Cодержание управления микшером                 \033[32mget or sget <SCONTROL>       \033[0m";}
 M23(){ TPUT 30 3; $e " Отображает список элементов управления карты   \033[32mcontrols                     \033[0m";}
 M24(){ TPUT 31 3; $e " Отображает список карточек с их содержимым     \033[32mcontents                     \033[0m";}
 M25(){ TPUT 32 3; $e " Задает содержимое элемента управления картой   \033[32mcset <CONTROL> <PARAMETER>   \033[0m";}
 M26(){ TPUT 33 3; $e " Cодержимое элемента управления картой          \033[32mcget <CONTROL>               \033[0m";}
#
 M27(){ TPUT 35 3; $e " Баланс наушников                                                            ";}
 M28(){ TPUT 36 3; $e " Скрипт горячих клавиш звука                    \033[32mxbindkeys                    \033[0m";}
 M29(){ TPUT 37 3; $e " Показать уровень звука                                                      ";}
 M30(){ TPUT 38 3; $e " \033[32mGrannik Git                                                                 \033[0m";}
#
 M31(){ TPUT 40 3; $e " EXIT                                                                        ";}
#
LM=31
   MENU(){ for each in $(seq 0 $LM);do M${each};done;}
    POS(){ if [[ $cur == up ]];then ((i--));fi
           if [[ $cur == dn ]];then ((i++));fi
           if [[ $i -lt 0   ]];then i=$LM;fi
           if [[ $i -gt $LM ]];then i=0;fi;}
REFRESH(){ after=$((i+1)); before=$((i-1))
           if [[ $before -lt 0  ]];then before=$LM;fi
           if [[ $after -gt $LM ]];then after=0;fi
           if [[ $j -lt $i      ]];then UNMARK;M$before;else UNMARK;M$after;fi
           if [[ $after -eq 0 ]] || [ $before -eq $LM ];then
           UNMARK; M$before; M$after;fi;j=$i;UNMARK;M$before;M$after;}
   INIT(){ R;HEAD;FOOT;MENU;}
     SC(){ REFRESH;MARK;$S;$b;cur=`ARROW`;}
# Функция возвращения в меню
     ES(){ MARK;$e " ENTER = main menu ";$b;read;INIT;};INIT
  while [[ "$O" != " " ]]; do case $i in
# Здесь необходимо следить за двумя перепенными 0) и S=M0 Они должны совпадать между собой и переменной списка M0().
  0) S=M0 ;SC;if [[ $cur == enter ]];then R;echo -e "\033[32m sudo apt-get update
 sudo apt-get install alsa-utils\033[0m";ES;fi;;
  1) S=M1 ;SC;if [[ $cur == enter ]];then R;echo -e "
 Основной файл конфигурации.
 Обрабатывается первым при запуске системы или при подключении нового устройства.
 Отвечает за расположение всех остальных файлов конфигурации:
\033[32m cat /usr/share//alsa/alsa.conf\033[0m

 Таблица соответствия между именами устройств уровня ядра и подробными описаниями
 свойств звуковых карт
\033[32m cat /usr/share/alsa/cards/aliases.conf\033[0m
";ES;fi;;
  2) S=M2 ;SC;if [[ $cur == enter ]];then R;echo " amixer [-option] [cmd]
 amixer -c [card-number] set [control] [value]
 Во всех ваших командах amixer вам нужно указывать три вещи:
 1. Звуковая карта (номер карты), свойством которой вы хотите управлять.
 2. Устройство/элемент управления, громкостью которого вы хотите управлять.
 3. Значение громкости в процентах или децибелах, которое вы хотите установить,
 увеличить или уменьшить.
 4. хотите ли вы отключить звук для звуковой карты.";ES;fi;;
  3) S=M3 ;SC;if [[ $cur == enter ]];then R;echo " amixer позволяет управлять микшером из командной строки для драйвера звуковой
 карты ALSA.
 amixer поддерживает несколько звуковых карт.
 amixer без аргументов отобразит текущие настройки микшера для звуковой карты и
 устройства по умолчанию. Это хороший способ увидеть список простых микшеров
 элементы управления, которые вы можете использовать.
 Alsamixer - графический интерфейс для ALSA
 Amixer -    командный интерфейс для ALSA";ES;fi;;
  4) S=M4 ;SC;if [[ $cur == enter ]];then R;echo " alsamixer alsactl";ES;fi;;
  5) S=M5 ;SC;if [[ $cur == enter ]];then R;echo " Никто не известен.";ES;fi;;
  6) S=M6 ;SC;if [[ $cur == enter ]];then R;echo " amixer — Ярослав Кисела: perex@perex.cz
 Этот документ составлен Полом Винклером: zarmzarm@erols.com
 и Ярославом Киселой: perex@perex.cz";ES;fi;;
  7) S=M7 ;SC;if [[ $cur == enter ]];then R;echo -e "\033[32m amixer\033[0m";ES;fi;;
  8) S=M8 ;SC;if [[ $cur == enter ]];then R;echo -e " Выберите номер карты для управления. Имя устройства, созданное из этого параметра
 Имеет синтаксис «hw:N», где N — указанный номер карты.
 Следующая команда установит громкость на главном элементе управления/устройстве
 первой звуковой карты на 3 дБ:
\033[32m amixer -c 0 set Master 3db\033[0m
 Следующая команда установит громкость на главном элементе управления/устройстве
 первой звуковой карты на 1 дБ:
\033[32m amixer -c 0 set Master 1db+\033[0m
";ES;fi;;
  9) S=M9 ;SC;if [[ $cur == enter ]];then R;echo -e "
 Выберите имя устройства для управления.
 Имя элемента управления по умолчанию default:
\033[32m amixer -D pulse set Master 3%+ unmute\033[0m
\033[32m amixer -D pulse set Master 3%- unmute\033[0m
";ES;fi;;
 10) S=M10 ;SC;if [[ $cur == enter ]];then R;echo "  Прочитайте со стандартного ввода и последовательно выполните команду в каждой
 строке. Когда указан этот параметр, команда в аргументах командной строки
 игнорируется.
 Принимаются только sset и cset. Другие команды игнорируются.
 Команды для несовпадающих идентификаторов также игнорируются без ошибок.";ES;fi;;
 11) S=M11 ;SC;if [[ $cur == enter ]];then R;echo -e " Справка, показать синтаксис:
\033[32m amixer -h\033[0m";ES;fi;;
 12) S=M12 ;SC;if [[ $cur == enter ]];then R;echo -e "
 Бесшумный режим. Не показывать результаты изменений:
\033[32m amixer -q sset Master "20%" on\033[0m
#
\033[32m amixer -q sset Master 100\033[0m
";ES;fi;;
 13) S=M13 ;SC;if [[ $cur == enter ]];then R;echo " Используйте необработанное значение для оценки процентного представления.
 Это режим (по умолчанию)";ES;fi;;
 14) S=M14 ;SC;if [[ $cur == enter ]];then R;echo " Используйте сопоставленный объем для оценки процентного представления,
 такого как alsamixer, чтобы он был более естественным для человеческого уха.";ES;fi;;
 15) S=M15 ;SC;if [[ $cur == enter ]];then R;echo -e " Показывает синтаксис:
\033[32m amixer --help\033[0m";ES;fi;;
 16) S=M16 ;SC;if [[ $cur == enter ]];then R;echo -e " \033[32m amixer info\033[0m";ES;fi;;
 17) S=M17 ;SC;if [[ $cur == enter ]];then R;echo -e " Команда scontrols позволяет просматривать список элементов управления,
 которыми вы можете управлять:
\033[32m amixer scontrols\033[0m";ES;fi;;
 18) S=M18 ;SC;if [[ $cur == enter ]];then R;echo -e " Показывает полный список простых элементов управления микшера с их содержимым:
\033[32m amixer scontents\033[0m";ES;fi;;
 19) S=M19 ;SC;if [[ $cur == enter ]];then R;echo -e "\e[31m Потом правда не включается... Придется оборудование подбирать.\e[0m
 отключить звук устройства:\033[32m amixer -c 0 set Master mute\033[0m
 включить звук устройства: \033[32m amixer -c 0 set Master unmute\033[0m
 ";ES;fi;;
 20) S=M20 ;SC;if [[ $cur == enter ]];then R;echo -e "
 Параметр может быть громкостью в процентах от 0% до 100%:
\033[32m amixer set Master 100%\033[0m
#
 Следующая команда установит громкость на главном элементе управления/устройстве
 первой звуковой карты на 3 дБ:
\033[32m amixer set Master 3db\033[0m
#
 точное аппаратное значение:
\033[32m amixer set Master 100\033[0m
#
 Параметры cap, nocap, toggle используются для изменения захвата (записи)
 и приглушения для указанной группы.";ES;fi;;
#
 21) S=M21 ;SC;if [[ $cur == enter ]];then R;echo -e "
 Усиление в дБ можно использовать только для элементов микшера
 с доступной информацией в дБ. Когда плюс(+)
 или после значения громкости добавляется буква минус(-), громкость соответственно
 увеличивается или уменьшается от текущего значения.
+~~~~~~~~~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~~~~~~~~~~+
| громче                 | тише                    |
+------------------------+-------------------------+
 Параметр может быть громкостью в процентах от 0% до 100%:
|\033[32m amixer set Master 10%+\033[0m | \033[32m amixer set Master 10%-\033[0m |
 Следующая команда установит громкость на главном элементе управления/устройстве
 первой звуковой карты на 3 дБ:
|\033[32m amixer set Master 1db+\033[0m | \033[32m amixer set Master 1db-\033[0m |
 точное аппаратное значение:
|\033[32m amixer set Master 10+\033[0m  | \033[32m amixer set Master 10-\033[0m  |
+~~~~~~~~~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~~~~~~~~~~+
 ";ES;fi;;
 22) S=M22 ;SC;if [[ $cur == enter ]];then R;echo " Показывает содержание простого управления микшером.
 Необходимо указать простое управление микшером.
 Одновременно можно управлять только одним устройством.";ES;fi;;
 23) S=M23 ;SC;if [[ $cur == enter ]];then R;echo " Отображает полный список элементов управления карты.";ES;fi;;
 24) S=M24 ;SC;if [[ $cur == enter ]];then R;echo " Отображает полный список карточек с их содержимым.";ES;fi;;
 25) S=M25 ;SC;if [[ $cur == enter ]];then R;echo "  Задает содержимое элемента управления картой.
 Идентификатор имеет следующие компоненты:
 iface, name, index, device, subdevice, numid.
 Следующий аргумент указывает значение контроля.";ES;fi;;
 26) S=M26 ;SC;if [[ $cur == enter ]];then R;echo " Показывает содержимое элемента управления картой.
 Идентификатор имеет тот же синтаксис, что и для команды cset.";ES;fi;;
#
 27) S=M27 ;SC;if [[ $cur == enter ]];then R;echo -e "\033[32m amixer cset name='Headphone Playback Volume' 84%,100% \033[0m";ES;fi;;
 28) S=M28 ;SC;if [[ $cur == enter ]];then R;echo -e "\e[31m
 \"amixer -c 0 sset Master 2-\"
 XF86AudioLowerVolume
 \"amixer -c 0 sset Master 2+\"
 XF86AudioRaiseVolume
\e[0m";ES;fi;;
 29) S=M29 ;SC;if [[ $cur == enter ]];then R;echo -e "\033[32m awk -F\"[][]\" '/dB/ { print \$2 }' <(amixer sget Master)\033[0m";ES;fi;;
 30) S=M30 ;SC;if [[ $cur == enter ]];then R;echo -e "
 mAmixer Описание утилиты amixer.
 Mикшер командной строки для драйвера звуковой карты ALSA
 https://gitlab.com/grannik/mamixer
 https://framagit.org/GrannikOleg/mamixer
 https://bitbucket.org/grannikoleg/mamixer/src/master/
 https://codeberg.org/Grannik/mAmixer
 https://notabug.org/Grannikoleg/mAmixer
 https://sourceforge.net/projects/mamixer/files/
 https://github.com/GrannikOleg/mAmixer
 https://asciinema.org/a/488634
";ES;fi;;
#
 31) S=M31;SC;if [[ $cur == enter ]];then R;ls -l;exit 0;fi;;
 esac;POS;done
