import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:qualplaca/models/gpu_model.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({
    super.key,
    required this.gpu,
    required this.recommended,
  });
  final GPU gpu;
  final List<GPU> recommended;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  ConfettiController? confettiController;

  @override
  void initState() {
    super.initState();
    confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    confettiController?.play();
  }

  @override
  void dispose() {
    confettiController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeData.light().scaffoldBackgroundColor,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 30,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Expanded(
                                  child: Text(
                                    "Resultado",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Com base nas informações obtidas o melhor resultado está logo abaixo",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Card(
                          elevation: 0,
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 200,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Image.network(
                                  widget.gpu.urlImage,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.gpu.name,
                                      style: const TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Marca: ${widget.gpu.brand}',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'VRAM: ${widget.gpu.vram} GB',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Clock: ${widget.gpu.clock} Hz',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Interface de memória: ${widget.gpu.memoryInterface} bits',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Consumo: ${widget.gpu.energy} W',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Preço: R\$${widget.gpu.price}',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Wrap(
                                      spacing: 2.0,
                                      children: widget.gpu.tags.map((tag) {
                                        return Chip(
                                          label: Text(tag),
                                          backgroundColor: Colors.white,
                                          labelStyle: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.recommended.isNotEmpty,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 30,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Expanded(
                                        child: Text(
                                          "Recomendações",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Também existem essas alternativas",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.recommended.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(20),
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 0.5,
                                        color: Colors.black,
                                      ),
                                    ),
                                    leading: Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            widget.recommended[index].urlImage,
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      widget.recommended[index].name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Marca: ${widget.recommended[index].brand}'),
                                        Text(
                                            'VRAM: ${widget.recommended[index].vram} GB'),
                                        Text(
                                          'Clock: ${widget.recommended[index].clock} Hz',
                                        ),
                                        Text(
                                          'Interface de memória: ${widget.recommended[index].memoryInterface} bits',
                                        ),
                                        Text(
                                          'Consumo: ${widget.recommended[index].energy} W',
                                        ),
                                        Text(
                                            'Preço: R\$${widget.recommended[index].price}'),
                                        Wrap(
                                          spacing: 2.0,
                                          children: widget.gpu.tags.map((tag) {
                                            return Chip(
                                              label: Text(tag),
                                              backgroundColor: Colors.black,
                                              labelStyle: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ConfettiWidget(
                      confettiController: confettiController!,
                      blastDirectionality: BlastDirectionality.explosive,
                      emissionFrequency: 0.1,
                      shouldLoop: false,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ConfettiWidget(
                      confettiController: confettiController!,
                      blastDirectionality: BlastDirectionality.explosive,
                      emissionFrequency: 0.1,
                      shouldLoop: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
