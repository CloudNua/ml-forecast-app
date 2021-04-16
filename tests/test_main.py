import unittest

class TestTuple(unittest.TestCase):

     # check they are the same type
    def test_1(self):
        stocks = ('TSLA', 'AAPL')
        self.assertEqual(type(stocks), type(('TSLA', 'AAPL')))

    # check they are the same length
    def test_2(self):
        stocks = ('TSLA', 'AAPL')
        self.assertEqual(len(stocks), len(('TSLA', 'AAPL')))

    # check they have the same string
    def test_3(self):
        stocks = ('TSLA', 'AAPL')
        self.assertEqual(stocks[1], ('TSLA', 'AAPL')[1])

    # check they have the same list
    def test_4(self):
        stocks = ('TSLA', 'AAPL')
        self.assertCountEqual(stocks[0], ('TSLA', 'AAPL')[0])