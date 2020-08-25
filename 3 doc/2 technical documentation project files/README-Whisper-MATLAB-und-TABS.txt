Das  Whisper Konfigurationstool "Presets' defaults system" (erreichbar via "edit"->"configure defaults' presets")
beinhaltet in seinem GUI sogenannte Tabs, Karteireiter.
Diese sind in Matlab und dem GUIDE selbst nicht verf�gbar, realisiert wurden sie darum mit dem Matlabs Funktionalit�t 
erweiternden Hilfstool "Tabpanel Constructor" (http://www.mathworks.com/matlabcentral/fileexchange/6996-tabpanel-constructor-v2-7-2010), Version 2.7.

Dieser erm�glicht relativ unaufw�ndig das Erstellen von Tabs und anschlie�ende in GUIDE wie gewohnt stattfindende 
Bev�lkern mit Bedienelementen, siehe das ihm beiliegende "manual".

Der Tabpanel-Constructor ist zudem erfreulicherweise _nicht_ vonn�ten, um mithilfe von ihm erzeugte Matlab-GUIs mit 
Tabs ablaufen zu lassen und zu nutzen.

Ein Fallstrick im Zusammenhang mit der sonst automatischen Erzeugung der "exotischeren" der Callbacks (z.B. KeyPressFcn)
und Anzeige im Editor zur komfortablen Editierung nach Anwahl von "View Callbacks..." im Rechtsklickmenu von
Gui-Elementen: Wird der Inhalt eines Tabs von GUIDE editiert, dann bearbeitet GUIDE dann eine tempor�re *.fig, deren Inhalt
nach Ende der Konfiguration von Tabpanel-Constructor in die eigentliche *.fig mit den dann Tabs enthaltende GUI
schreibt; die Callbacks k�nnen darum nicht wie �blich und oben beschrieben erzeugt werden.

Vorzugehen ist stattdessen so: die eigentliche *.fig wird per Rechtsklick in GUIDE ge�ffnet (zu sehen ist die GUI mit dem 
Platzhalter f�r die Tabs). Es wird der Object-Browser aufgerufen. Das gew�nschte Bedienelement wird markiert.
Aus dem Fenstermenu des GUIDE wird "View Callbacks..." etc. aufgerufen und der gew�nschte Callback. Dieser wird nun 
wie gewohnt ggfalls erzeugt und im Editor markiert ge�ffnet und zur Bearbeitung pr�sentiert.

(Matthias Herder, Juni 2010)
