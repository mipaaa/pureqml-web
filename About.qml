HistoryPage {
	height: contentRect.height;
	anchors.top: parent.top;
	anchors.left: parent.left;
	anchors.right: parent.right;
	url: "about";

	LeftMenu { id: leftMenu; onIndexChoosed(idx): { aboutContent.focusItem(idx) } }

	Rectangle {
		id: contentRect;
		height: aboutContent.contentHeight + 30;
		anchors.top: parent.top;
		anchors.left: leftMenu.right;
		anchors.right: parent.right;
		anchors.leftMargin: 10;
		color: colorTheme.panelColor;

		ContentColumn {
			id: aboutContent;
			anchors.top: parent.top;
			anchors.left: parent.left;
			anchors.right: parent.right;
			anchors.margins: 10;
			spacing: 30;

			PageColumn {
				title: "QMLCore";
				text: "QMLCore - QML to JS translator. QMLCore is simple tool we (small team of QML advocates) used for years, simplifying building of html5 UI for both mobile and desktop targets. It was designed with original QML in mind, but it's not 100% compatible and better in some aspects. The main concepts are the same though, so if you're familiar with original QML, you could start right away.";
			}

			PageColumn {
				title: "Usage";
				text: "QMLCore provides a set of tools written in python2 (sorry about that, lol) Usually you don't need to use them directly. build provides convenient wrapper around them all.";
			}

			PageColumn {
				title: "Prerequisites";
				text: "Any modern python 2.x will go well. Jinja2 is better option for templating in case you want more than qml loader in your html file, but it's not required for small apps.";
			}

			PageColumn {
				title: "Simple how-to";

				ListView {
					height: contentHeight;
					anchors.left: parent.left;
					anchors.right: parent.right;
					anchors.leftMargin: 20;
					spacing: 5;
					model: ListModel {
						ListElement { text: "Create project directory,"; code: "cd &lt;project-dir&gt;"; }
						ListElement { text: "Clone qmlcore to it:"; code: "git clone git@github.com:pureqml/qmlcore.git"; }
						ListElement { text: "Run"; code: "./qmlcore --boilerplate"; }
						ListElement { text: "Look into "; code: "app.qml"; }
						ListElement { text: "Run"; code: "./qmlcore/build"; }
						ListElement { text: "Please find resulting files in"; code: ".app.html5/*";}
					}
					delegate: Item {
						width: parent.width;
						height: valueText.height;

						Rectangle {
							width: height;
							height: 10;
							anchors.verticalCenter: parent.verticalCenter;
							radius: width / 2;
							color: colorTheme.primaryColor;
						}

						Text {
							id: valueText;
							width: model.code ? paintedWidth : (parent.width - 40);
							anchors.left: parent.left;
							anchors.bottom: parent.bottom;
							anchors.leftMargin: 20;
							font.pixelSize: 21;
							font.weight: 300;
							wrapMode: model.code ? Text.NoWrap : Text.WordWrap;
							color: colorTheme.textColor;
							text: model.text;
						}

						Text {
							height: parent.height;
							anchors.left: parent.left;
							anchors.right: parent.right;
							anchors.bottom: parent.bottom;
							anchors.leftMargin: valueText.paintedWidth + 30;
							font.weight: 400;
							font.pixelSize: 21;
							text: model.code;
							visible: model.code;
						}
					}
				}
			}

			PageColumn {
				title: "How it works";
				text: "Qml compiler scans source directories for qml file and parses each one. Filename starting with uppercase letter considered component, lowercase instantiated. Project-wide options stored in .manifest file. Result of the compilation is single javascript file with minimum dependencies (modernizr only), ready to use in mobile and desktop environment, accompanied by sample .html launcher and flash video player.";
			}

			PageColumn {
				title: "Manifest options";
				text: "Manifest is a collection of project-wide hacks we used to botch various projects. Some of them may or may not be useful.";

				KeyValueView {
					anchors.leftMargin: 20;
					model: ListModel {
						ListElement { key: "apps"; value: "dictionary of application and their templates, { app1: template1, app2: template2, app3: template1 }. Templates are taken from dist/ or platform/*/dist directory"; }
						ListElement { key: "templater"; value: "template engine to use, only 'simple' and 'jinja2' are supported at the moment"; }
						ListElement { key: "web-prefix"; value: "see -p option below, specify css rules prefix"; }
						ListElement { key: "minify"; value: "false/true or compiler name as string, only 'gcc' and 'uglify-js' are supported. google closure compiler requires java to run."; }
						ListElement { key: "platforms"; value: "use additional platform/*/ files, default and only platform is 'html5' for now"; }
						ListElement { key: "path"; value: "additional directories to search sources for"; }
					}
				}

				DescriptionText { text: "build tool command line options"; }

				KeyValueView {
					shift: 270;
					anchors.leftMargin: 20;
					model: ListModel {
						ListElement { key: "-m, --minify"; value: "minify with default option ('uglify-js')"; }
						ListElement { key: "-k, --keep"; value: "keep original source after minification, useful for debugging minification warnings"; }
						ListElement { key: "-d, --devel"; value: "development mode, keep running and wait for changes, requires inotify module"; }
						ListElement { key: "-p, --web-prefix"; value: "web prefix, removed default CSS rules, adds 'qml-' prefix for them, allowing you to interchange HTML/QML"; }
						ListElement { key: "-u, --update-translation"; value: "update translation files, specified in manifest.languages"; }
						ListElement { key: "--boilerplate"; value: "initialises bare minimum for quicker kick-off in current directory."; }
					}
				}
			}

			PageColumn {
				title: "Localisation";
				text: "QmlCore uses Qt-approach to localisation. You write code in your default language, then generate/update (build -u) .ts translation files, translate them with qt linguist, and compile project. QmlCore recognizes tr, qsTr, qsTranslate function, as well as QT_TR_NOOP/QT_TRANSLATE_NOOP macros.";
			}

			PageColumn {
				title: "Controls library";
				text: "QmlCore contains bare minimum of platform controls: images, texts, rectangles and model-view-delegate classes. Various controls that might be useful are in separate repository. Just clone it git clone git@github.com:pureqml/controls.git in your project and that's it!";
			}

			PageColumn {
				title: "QML differences";
				text: "";

				Text {
					anchors.left: parent.left;
					color: colorTheme.primaryColor;
					font.weight: 300;
					font.pixelSize: 25;
					text: "Grammar"; 
				}

				DescriptionText { text: "We require semicolon after each statement. This may be changed in future."; }

				Text {
					anchors.left: parent.left;
					color: colorTheme.primaryColor;
					font.weight: 300;
					font.pixelSize: 25;
					text: "Focus"; 
				}

				DescriptionText { text: "The biggest discrepancy with original QML is focus implementation. We're aiming to have \"always-consistent\" focus everywhere. You have to mark every focus-able component with focus: true; property, and the rest should work without tweaking. We provide several convenient properties to handle focus with ease:"; }

				KeyValueView {
					anchors.leftMargin: 20;
					model: ListModel {
						ListElement { key: "activeFocus"; value: "this item has current focus and got any user input first"; }
						ListElement { key: "focused"; value: "this item has current focus in its parent, but not necessarily focused globally"; }
					}
				}

				Text {
					anchors.left: parent.left;
					color: colorTheme.primaryColor;
					font.weight: 300;
					font.pixelSize: 25;
					text: "Adding modernizr features"; 
				}

				DescriptionText { text: "Please use the following command to get the custom modernizr build page: head -n2 dist/modernizr-custom.js | tail -n1 or just second line of modernizr-custom.js file"; }
			}

			onFillMenu(data): { leftMenu.fillModel(data) }
		}
	}
}
