import json
import logging
import random
import sys
import time
from datetime import datetime
from typing import Iterator

from flask import Flask, Response, render_template, request, stream_with_context

logging.basicConfig(stream=sys.stdout, level=logging.INFO)
logger = logging.getLogger(__name__)

application = Flask(__name__)
random.seed()  # Initialize the random number generator


@application.route("/")
def index() -> str:
    return render_template("index.html")


def generate_random_data() -> Iterator[str]:
    """
    Generates random value between 0 and 100

    :return: String containing current timestamp (YYYY-mm-dd HH:MM:SS) and randomly generated data.
    """
    try:
        logger.info("Client %s connected", request.remote_addr)
        while True:
            json_data = json.dumps(
                {
                    "time": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
                    "value": random.random() * 100,
                }
            )
            yield f"data:{json_data}\n\n"
            time.sleep(1)
    except GeneratorExit:
        logger.info("Client %s disconnected", request.remote_addr)


@application.route("/chart-data")
def chart_data() -> Response:
    return Response(stream_with_context(generate_random_data()), mimetype="text/event-stream")


if __name__ == "__main__":
    application.run(host="0.0.0.0", threaded=True)
