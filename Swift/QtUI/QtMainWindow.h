#ifndef SWIFT_QtMainWindow_H
#define SWIFT_QtMainWindow_H

#include <QWidget>
#include <QMenu>
#include "Swift/Controllers/MainWindow.h"

#include <vector>

class QComboBox;
class QLineEdit;
class QPushButton;

namespace Swift {
	class QtTreeWidget;
	class QtTreeWidgetFactory;
	class QtStatusWidget;
	class TreeWidget;


	class QtMainWindow : public QWidget, public MainWindow {
		Q_OBJECT
		public:
			QtMainWindow(QtTreeWidgetFactory *treeWidgetFactory);
			TreeWidget* getTreeWidget();
			std::vector<QMenu*> getMenus() {return menus_;}
		private slots:
			void handleStatusChanged(StatusShow::Type showType, const QString &statusMessage);
			void handleShowOfflineToggled(bool);
			void handleJoinMUCAction();
			void handleJoinMUCDialogComplete(const JID& muc, const QString& nick);
		private:
			std::vector<QMenu*> menus_;
			QtStatusWidget *statusWidget_;
			QLineEdit *muc_;
			QLineEdit *mucNick_;
			QPushButton *mucButton_;
			QtTreeWidget *treeWidget_;
	};
}

#endif

