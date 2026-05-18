from flask import Flask, json, send_file, jsonify

app = Flask(__name__)

@app.route('/study/contents/image/hoge.jpg')
def get_image():
    return send_file(
        'hoge.jpg',
        mimetype='image/jpeg'
    )

@app.route('/study/contents/layout')
def get_layout():
    with open('server/layoutinfo.json', 'r') as f:
        layout_info = json.load(f)

    return jsonify(layout_info)

if __name__ == '__main__':
    # http://localhost:5000/study/contents/image/hoge.jpg にアクセスすると、hoge.jpgが表示される
    app.run(
        host='127.0.0.1',
        port=5000
    )
