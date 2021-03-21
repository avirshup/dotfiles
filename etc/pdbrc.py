import os as _os

_PDB_HISTORY_PATH = _os.path.expanduser("~/.pdb.d/pdbhistory")
_PDB_HISTORY_LEN = 10000

def _save_pdb_history(path=_PDB_HISTORY_PATH, length=_PDB_HISTORY_LEN):
    import readline
    readline.set_history_length(length)
    readline.write_history_file(path)
    # print(f' ** saved PDB history to {path}')

def _load_pdb_history(path=_PDB_HISTORY_PATH, callback=_save_pdb_history):
    import atexit, os, readline

    atexit.register(callback)
    if os.path.exists(path):
        readline.read_history_file(path)
        # print(f' ** loaded PDB history from {path}')
    else:
        print(' ** no PDB history found')


_load_pdb_history()