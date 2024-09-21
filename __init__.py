import hy
from trytond.pool import Pool
from . import table

def register():
    Pool.register(
        table.Table,
        module='babi_export', type_='model')
