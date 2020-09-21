# coding: utf-8
import requests

class Designer:
    def __init__(self, name, seniority=0, awards=2):
        self.name = name
        self.seniority = seniority
        self.awards = awards

    def check_if_it_is_time_for_upgrade(self):
        self.seniority += 1

