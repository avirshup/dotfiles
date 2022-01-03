# to be placed in ~/.ipython/profile_default/startup/init_pprint.py 
# or similar
# https://prettyprinter.readthedocs.io/en/latest/usage.html#usage-with-ipython


AMV_DEF_STYLE = "native"


def _setup_pprint():
    from datetime import datetime

    try:
        import prettyprinter.prettyprinter

    except ImportError:
        print("*** prettyprinter not found")
        return


    prettyprinter.install_extras(
        include=[
            x for x in prettyprinter.ALL_EXTRAS if x not in ("attrs", "dataclasses")
        ],
        warn_on_error=False,
    )

    # register custom prettyprinters that show default values, doesn't call factories
    prettyprinter.prettyprinter.register_pretty(type=datetime)(_custom_print_dt)

    try:
        prettyprinter.prettyprinter.register_pretty(predicate=_isdc)(
            _custom_print_dataclass
        )
    except ImportError:
        pass

    try:
        prettyprinter.prettyprinter.register_pretty(
            predicate=lambda v: hasattr(type(v), "__attrs_attrs__")
        )(_custom_pprint_attrs)
    except ImportError:
        pass
    

    amv_switch_style(AMV_DEF_STYLE)
    amv_switch_pprint_style(AMV_DEF_STYLE)
    print("*** prettyprinter installed")
    return True


def amv_switch_pprint_style(style_name):
    import prettyprinter

    try:
        from pygments import styles
    except ImportError:
        print(" *** pygments not found")
        return

    prettyprinter.set_default_style(styles.get_style_by_name(style_name))


def amv_switch_style(style_name):
    try:
        from pygments import styles
    except ImportError:
        print(" *** pygments not found")
        return

    ipy = get_ipython()
    ipy.colors = "linux"
    ipy.highlighting_style = styles.get_style_by_name(style_name)


def _get_testdata():
    import dataclasses
    from datetime import datetime

    @dataclasses.dataclass
    class MyDataClass:
        some_number: int = 55
        some_dict: dict = dataclasses.field(default_factory=lambda: {"key": "val"})
        some_list: list = dataclasses.field(
            default_factory=lambda: ["item1", ("item", 2)]
        )
        recursion: "MyDataClass" = None

    return {
        "a": 1,
        "b": [1, 2, (3 + 5j), {"hello"}],
        "mydc": MyDataClass(recursion=MyDataClass()),
        'now': datetime.utcnow()
    }


def amv_show_all_styles(data=None):
    from prettyprinter import cpprint
    from pygments import styles

    if data is None:
        data = _get_testdata()

    for style in styles.get_all_styles():
        print(f"{style}:")
        try:
            cpprint(data, style=styles.get_style_by_name(style))
        except Exception as exc:
            print(repr(exc))
        print()



def _custom_pprint_attrs(value, ctx):
    """'fork' of https://github.com/tommikaikkonen/prettyprinter/blob/53ba5f934f2/prettyprinter/extras/attrs.py
    that doesn't omit default values
    """
    from prettyprinter.prettyprinter import pretty_call_alt

    cls = type(value)
    attributes = cls.__attrs_attrs__

    kwargs = []
    for attribute in attributes:
        if attribute.repr:
            kwargs.append((attribute.name, getattr(value, attribute.name)))
    return pretty_call_alt(ctx, cls, kwargs=kwargs)


def _isdc(val):
    from dataclasses import fields

    try:
        fields(val)
    except TypeError:
        return False
    else:
        return True


def _custom_print_dataclass(value, ctx):
    """'fork' of https://github.com/tommikaikkonen/prettyprinter/blob/53ba5f934f2/prettyprinter/extras/dataclasses.py
    that doesn't omit default values
    """
    from prettyprinter.prettyprinter import pretty_call
    from collections import OrderedDict
    from dataclasses import fields

    cls = type(value)
    field_defs = fields(value)

    kwargs = []
    for field_def in field_defs:
        # repr is True by default,
        # therefore if this if False, the user
        # has explicitly indicated they don't want
        # to display the field value.
        if field_def.repr:
            kwargs.append((field_def.name, getattr(value, field_def.name)))

    return pretty_call(ctx, cls, **OrderedDict(kwargs))


def _custom_print_dt(value, ctx):
    from prettyprinter.prettyprinter import pretty_call

    from datetime import datetime

    dt: datetime = value.astimezone()
    cs = int(dt.microsecond) // 10000
    return pretty_call(ctx, datetime, dt.strftime(f"%X.{cs} %x %Z"))


_setup_pprint()