import 'package:cubit_movies/domain/responses/movies_response.dart';
import 'package:cubit_movies/shared/widgets/app_network_image.dart';
import 'package:cubit_movies/shared/widgets/rating.dart';
import 'package:cubit_movies/shared/constants/app_values.dart';
import 'package:cubit_movies/shared/styles/colors.dart';
import 'package:flutter/material.dart';

Widget buildMovieItem({
  required BuildContext context,
  required MoviesResponse movie,
  required void Function()? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.all(2),
    child: ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 280,
      ),
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2 - 28,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: AppColors.black.withOpacity(0.1),
                  child: AspectRatio(
                    aspectRatio: 27 / 40,
                    child: Hero(
                      tag: movie.id.toString() + movie.posterPath.toString() + AppValues.heroPoster,
                      child: AppNetworkImage(
                        url: AppValues.imageUrl + (movie.posterPath ?? ''),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: buildRating(
                    context: context,
                    votes: movie.voteAverage ?? 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    movie.title ?? '',
                    style: Theme.of(context).textTheme.headline3,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: onTap,
      ),
    ),
  );
}
