
import os
import sys
import pandas as pd

if __name__ == '__main__':
    path = 0
    for arg in sys.argv[1:]:
        if isinstance(arg, str):
            BASEDIR = os.path.dirname(os.path.realpath(__file__))
            relpath = os.path.join(BASEDIR, '..', 'cache', arg) 
            if os.path.isfile(relpath): path = relpath
            else:
                name = arg
        else:
            pass
            
    if path != 0:
        df = pd.read_csv(path, encoding='unicode_escape')
        print(pd.io.sql.get_schema(df.reset_index(), name))
        sys.stdout.flush()
    else:
        raise Exception("Illegal path.")
        sys.stdout.flush()

