import 'package:flutter/material.dart';
import 'package:qrcodeapp/src/ui/components/enviar_email/index.dart';
import 'package:qrcodeapp/src/ui/components/gerar_qr_code/index.dart';
import 'package:qrcodeapp/src/ui/components/ler_qr_code/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exemplo de QR Code')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: TextButton(
                  onPressed: () async {
                    var qrcode = QRCodeFactory(context);
                    /*qrcode.showQrCode(
                        titulo: 'Senha de acesso',
                        value: "http://www.raulivan.com.br");*/

                    //Gerar o QrCode e salva como imagem
                    var qrcodeimg =
                        await qrcode.SaveToFileQrCode(value: "20220101");

                    //Envia o QRCode por email
                    SendEmail(context).SendQrCode(
                        assunto: "Sua senha de acesso",
                        caminhoQrCode: qrcodeimg,
                        destinatarios: [
                          'raulivanrodrigo@yahoo.com.br',
                          'puericulturaprojeto2022@gmail.com'
                        ]);
                  },
                  child: const Text('Gerar QR Code'))),
          Center(
              child: TextButton(
                  onPressed: () async {
                    //Le o QrCode e devolve o valor lido
                    String codigoLido = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => QrCodeRed()));

                    //Apenas pra exibir o QrCode lido
                    var btnOK = TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'));

                    var alerta = AlertDialog(
                      title: const Text('Falha ao enviar o e-mail'),
                      content: SizedBox(
                        width: 350,
                        height: 350,
                        child: Center(child: Text(codigoLido)),
                      ),
                      actions: [btnOK],
                    );

                    showDialog(
                        context: context,
                        builder: (BuildContext context) => alerta);
                  },
                  child: const Text('Ler QR Code')))
        ],
      ),
    );
  }
}
