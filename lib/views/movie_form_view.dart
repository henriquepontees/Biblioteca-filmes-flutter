import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../models/movie_model.dart';
import '../controllers/movie_controller.dart';

class MovieFormView extends StatefulWidget {
  final Movie? movie;
  final Function() onSave;

  const MovieFormView({
    Key? key,
    this.movie,
    required this.onSave,
  }) : super(key: key);

  @override
  _MovieFormViewState createState() => _MovieFormViewState();
}

class _MovieFormViewState extends State<MovieFormView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = MovieController();

  late String _imageUrl;
  late String _title;
  late String _genre;
  late String _ageRating;
  late String _duration;
  double _rating = 0;
  late String _description;
  late String _year;

  final List<String> _ageRatings = [
    'Livre',
    '10',
    '12',
    '14',
    '16',
    '18',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.movie != null) {
      _imageUrl = widget.movie!.imageUrl;
      _title = widget.movie!.title;
      _genre = widget.movie!.genre;
      _ageRating = widget.movie!.ageRating;
      _duration = widget.movie!.duration;
      _rating = widget.movie!.rating;
      _description = widget.movie!.description;
      _year = widget.movie!.year.toString();
    } else {
      _imageUrl = '';
      _title = '';
      _genre = '';
      _ageRating = 'Livre';
      _duration = '';
      _rating = 0;
      _description = '';
      _year = '';
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final movie = Movie(
        id: widget.movie?.id,
        imageUrl: _imageUrl,
        title: _title,
        genre: _genre,
        ageRating: _ageRating,
        duration: _duration,
        rating: _rating,
        description: _description,
        year: int.parse(_year),
      );

      if (widget.movie == null) {
        await _controller.addMovie(movie);
      } else {
        await _controller.updateMovie(movie);
      }

      widget.onSave();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie == null ? 'Adicionar Filme' : 'Editar Filme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _imageUrl,
                decoration: const InputDecoration(
                  labelText: 'URL da Imagem',
                  hintText: 'https://exemplo.com/imagem.jpg',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a URL da imagem';
                  }
                  return null;
                },
                onSaved: (value) => _imageUrl = value!,
              ),
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o título';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: _genre,
                decoration: const InputDecoration(labelText: 'Gênero'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o gênero';
                  }
                  return null;
                },
                onSaved: (value) => _genre = value!,
              ),
              DropdownButtonFormField<String>(
                value: _ageRating,
                decoration: const InputDecoration(labelText: 'Faixa Etária'),
                items: _ageRatings.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _ageRating = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecione a faixa etária';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _duration,
                decoration: const InputDecoration(labelText: 'Duração (min)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a duração';
                  }
                  return null;
                },
                onSaved: (value) => _duration = value!,
              ),
              const SizedBox(height: 16),
              const Text('Pontuação:'),
              RatingBar.builder(
              initialRating: _rating,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 40,
              itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              TextFormField(
                initialValue: _year,
                decoration: const InputDecoration(labelText: 'Ano'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o ano';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor, insira um ano válido';
                  }
                  return null;
                },
                onSaved: (value) => _year = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}