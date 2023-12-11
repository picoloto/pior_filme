const movieMock = {
  'id': 1,
  'year': 2022,
  'title': 'Sample Movie',
  'studios': ['Studio A', 'Studio B'],
  'producers': ['Producer X', 'Producer Y'],
  'winner': true,
};

const movieListDtoMock = {
  'content': [movieMock],
  'pageable': {'pageNumber': 0, 'pageSize': 10},
  'last': true,
  'totalPages': 2,
  'totalElements': 15,
  'size': 1,
  'number': 0,
  'sort': {'sorted': true},
  'first': true,
  'numberOfElements': 2,
  'empty': false,
};
