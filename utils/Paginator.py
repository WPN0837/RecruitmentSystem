class my_Paginator:
    '''
    自定义分页组件
    '''

    def __init__(self, data_list, info_num_page, page_num, current_page_num):
        self.data_list = data_list  # 要分页的数据
        self.info_num_page = info_num_page  # 每页数据的数量
        self.page_num = page_num  # 每页分页下标数量
        self.current_page_num = current_page_num  # 当前页码
        self.start = self.info_num_page * (self.current_page_num - 1)
        self.end = self.info_num_page * self.current_page_num

    @property
    def num_pages(self):
        '''
        返回总页数
        :return:
        '''
        a, b = divmod(len(self.data_list), self.info_num_page)
        if len(self.data_list) == 0:
            return 1
        if b:
            return a + 1
        return a

    @property
    def current_page_data_list(self):
        '''
        返回当前页的数据列表
        :return:
        '''
        return self.data_list[self.start:self.end]

    @property
    def next_page(self):
        '''
        下一页页码
        :return:
        '''
        if self.current_page_num + 1 >= self.num_pages or self.current_page_num <= 0:
            return self.num_pages
        return self.current_page_num + 1

    @property
    def previous_page(self):
        '''
        上一页页码
        :return:
        '''
        if self.current_page_num - 1 <= 1 or self.current_page_num > self.num_pages:
            return 1
        return self.current_page_num - 1

    @property
    def page_num_range(self):
        '''
        返回当前页下标列表
        :return:
        '''
        temp = self.page_num // 2
        if self.num_pages < self.page_num:
            return range(1, self.num_pages + 1)
        if temp >= self.current_page_num:
            return range(1, self.page_num + 1)
        if self.current_page_num >= self.num_pages - temp:
            return range(self.num_pages - self.page_num + 1, self.num_pages + 1)
        return range(self.current_page_num - temp, self.current_page_num + temp + 1)
