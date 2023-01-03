
import os
import sys
import pandas as pd

if __name__ == '__main__':
    for arg in sys.argv[1:]:
        if isinstance(arg, str):
            if os.path.isfile(arg):
                path = arg
        else:
            pass
            
    if path:
        df = pd.read_csv(path, encoding='unicode_escape')
        print(pd.io.sql.get_schema(df.reset_index(), 'data'))
        sys.stdout.flush()

