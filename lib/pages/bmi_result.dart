import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ResultPage extends StatefulWidget {
  const ResultPage({ Key? key, this.weight, this.height }) : super(key: key);
  final String? weight;
  final String? height;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  
  double? _bmi;
  String? _msg;
  
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'ค่า BMI',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: (){}, 
              icon: const Icon(Icons.favorite_border),
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(50),),
              Row(
                children: [
                  value(widget.weight!,' KG.',FontAwesomeIcons.weight,const EdgeInsets.fromLTRB(30, 0, 10, 0)),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  value(widget.height!,' CM.',FontAwesomeIcons.textHeight,const EdgeInsets.symmetric(horizontal: 10)),
                ],
              ),
              Column(
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  calbtn(context),
                  resultbox(),
                  answerbox(),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container resultbox() {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 25, 30, 10),
      padding: const EdgeInsets.only(top: 5),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 6),
            blurRadius: 12,
            color: Color(0xFF7A7A7A),
          )
        ],
      ),
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 5)),
          const Text(
            'BMI',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Text(
            _bmi == null ? '' : _bmi!.toStringAsFixed(2),
            style: const TextStyle(
                fontSize: 50, fontWeight: FontWeight.w700, color: Colors.green),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Container answerbox() {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 12,
            color: Color(0xFF7A7A7A),
          )
        ],
      ),
      child: Text(
        _msg == null ? '' : _msg!.toString(),
        // 'การแปลผล : ' + _msg.toString(),
        style: const TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
    );
  }



  Container value(a,u,ico,va) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 10,
            color: Color(0xFFB6B6B6),
          )
        ],
      ),
      margin: va,
      width: 160,
      height: 120,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              ico,
              color: Colors.green[700],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Text(
              a! + u,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  void calculate() {
    double height = double.parse(widget.height!) / 100;
    double weight = double.parse(widget.weight!);

    double heightExponent = height * height;

    setState(() {
      double bmi = weight / heightExponent;
      _bmi = bmi;
      if (_bmi! < 18.5) {
        _msg = 'น้ำหนักน้อยเกินไป';
      } else if (_bmi! <= 22.99) {
        _msg = 'น้ำหนักปกติ';
      } else if (_bmi! <= 24.99) {
        _msg = 'น้ำหนักเกิน (ท้วม)';
      } else if (_bmi! <= 29.99) {
        _msg = 'อ้วนระดับ 1 (อ้วนระยะเริ่มต้น)';
      } else if (_bmi! <= 39.99) {
        _msg = 'อ้วนระดับ 2 (อ้วนมาก)';
      } else {
        _msg = 'อ้วนระดับ 3 (อ้วนระดับรุนแรงมาก)';
      }
    });
  }

  Row calbtn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          icon: const FaIcon(FontAwesomeIcons.calculator),
          label: const Text(
            'คำนวณ',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            calculate();
          },
          style: ElevatedButton.styleFrom(
              // primary: Colors.pink,
              fixedSize: const Size(140, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
        ),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
        ElevatedButton.icon(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          label: const Text(
            'กลับ',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
              // primary: Colors.white,
              // side: const BorderSide(width: 3, color: Colors.green),
              fixedSize: const Size(140, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
        ),
      ],
    );
  }
}
