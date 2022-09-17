const List<String> CourseListFilterKeys = ['courseType', 'difficulty', 'isFree', 'q'];
const List<List<Map>> CourseListFilters = [
  [
    {
      'title': '全部类型',
      'value': 0,
    },
    {
      'title': '商业实战',
      'value': 1,
    },
    {
      'title': '专项好课',
      'value': 2,
    },
  ],
  [
    {
      'title': '全部难度',
      'value': -1,
    },
    {
      'title': '初级',
      'value': 1,
    },
    {
      'title': '中级',
      'value': 2,
    },
    {
      'title': '高级',
      'value': 3,
    },
    {
      'title': '架构',
      'value': 4,
    },
  ],
  [
    {
      'title': '全部价格',
      'value': -1,
    },
    {
      'title': '免费',
      'value': 0,
    },
    {
      'title': '付费',
      'value': 1,
    },
  ],
  [
    {
      'title': '默认排序',
      'value': -1,
    },
    {
      'title': '评价最高',
      'value': 1,
    },
    {
      'title': '学习最多',
      'value': 2,
    },
  ],
];
