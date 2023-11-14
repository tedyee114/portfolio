#region 0: import libraries and prepare environment
from flask import Flask, render_template, request, url_for
import sqlite3
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import io
import base64
import pandas as pd
import pathlib
web=True

a=pathlib.Path(__file__).parent.resolve()
print(a)
print(web)
if str(a)==r"C:\Users\tedye\Desktop\db_course\milesplit":
    web=False
print(a)
print(web)