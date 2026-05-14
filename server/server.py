from flask import Flask, send_file

app = Flask(__name__)

@app.route('/study/contents/image/hoge.jpg')
def get_image():
    return send_file(
        'hoge.jpg',
        mimetype='image/jpeg'
    )

if __name__ == '__main__':
    # http://localhost:5000/study/contents/image/hoge.jpg にアクセスすると、hoge.jpgが表示される
    app.run(
        host='127.0.0.1',
        port=5000
    )
