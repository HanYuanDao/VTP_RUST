import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import com.xinqi.vtp 1.0      // 替换成你自己项目的 URI

ApplicationWindow {
    id: appWin
    title: qsTr("Vtp 250626a")
    width: 1400; height: 900
    visible: true

    menuBar: MenuBar {
        Menu { title: qsTr("系统")   /* TODO: 添加 MenuItem */ }
        Menu { title: qsTr("配置")   /* TODO: 添加 MenuItem */ }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 10
        padding: 10

        // ─── 顶部账户信息 ──────────────────────────────────────────
        GridLayout {
            columns: 14
            rowSpacing: 4; columnSpacing: 20
            // 第一行
            Label { text: qsTr("账号") }
            Label { text: accountInfo.accountId }
            Label { text: qsTr("账户状态") }
            Label {
                text: accountInfo.status
                color: accountInfo.status === "正常" ? "green" : "red"
            }
            Label { text: qsTr("交易日") }
            Label { text: accountInfo.tradeDate }
            Label { text: qsTr("当前账户") }
            Label { text: accountInfo.currentAccount }
            // 第二行
            Label { text: qsTr("期货账户状态") }
            Label {
                text: accountInfo.futureStatus
                color: accountInfo.futureStatus === "在线" ? "green" : "red"
            }
            Label { text: qsTr("手续费") }
            Label { text: accountInfo.fee }
            Label { text: qsTr("当前账户盈亏") }
            Label { text: accountInfo.currentPnL }
            // 第三行
            Label { text: qsTr("隔节盈亏") }
            Label { text: accountInfo.sessionPnL }
            Label { text: qsTr("实际盈亏") }
            Label { text: accountInfo.actualPnL }
            Label { text: qsTr("强平线") }
            Label { text: accountInfo.marginLine }
            Label { text: qsTr("可用资金") }
            Label { text: accountInfo.availableFunds }
            Label { text: qsTr("总实际盈亏") }
            Label { text: accountInfo.totalPnL }
        }

        // ─── 中部：回合信息 & 下单信息 ────────────────────────────────
        RowLayout {
            spacing: 10
            Layout.fillWidth: true
            Layout.preferredHeight: 250

            // 回合信息
            GroupBox {
                title: qsTr("回合信息")
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout {
                    spacing: 6; padding: 6
                    RowLayout { spacing: 8
                        Button { text: qsTr("导出") }
                        Button { text: qsTr("重连") }
                    }
                    TableView {
                        id: tblRound
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        // TODO: 绑定你的 model，定义 columns
                    }
                }
            }

            // 下单信息
            GroupBox {
                title: qsTr("下单信息")
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout {
                    spacing: 6; padding: 6
                    RowLayout { spacing: 8
                        Button { text: qsTr("导出") }
                    }
                    TableView {
                        id: tblOrder
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        placeholderText: qsTr("没有更多数据了!")
                        // TODO: 绑定你的 model，定义 columns
                    }
                }
            }
        }

        // ─── 底部：结算单 & 持仓、订阅合约 ───────────────────────────
        ColumnLayout {
            spacing: 6

            // 操作按钮与文字
            RowLayout {
                spacing: 20
                Button { text: qsTr("结算单查询") }
                Label { text: qsTr("账户持仓合约: ") + accountInfo.heldContracts.join(",") }
                Button { text: qsTr("强制重连") }
                Label { text: qsTr("订阅合约: ") + accountInfo.subscribedContracts.join(",") }
            }

            // 三个并排表格
            RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Layout.fillHeight: true

                TableView {
                    id: tblPositions
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    // TODO: 定义 columns: 合约、总多仓、总空仓……
                }
                TableView {
                    id: tblMid
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    // TODO: 中间那张小表
                }
                TableView {
                    id: tblRight
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    // TODO: 右侧合并表格
                }
            }
        }
    }

    // —————— 假设这里是你的数据源 ContextProperties ——————
    // 在 main.rs 里或你的后端注册:
    //   engine.rootContext().setContextProperty("accountInfo", AccountModel {});
    //   // 并且为每张 TableView 设置 model
}