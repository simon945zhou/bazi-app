from flask import Flask, render_template, request, jsonify
from bazi_calculator import calculate_bazi, analyze_bazi, generate_fortune_report, get_lucky_suggestions
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/calculate', methods=['POST'])
def calculate():
    data = request.json
    try:
        year = int(data.get('year'))
        month = int(data.get('month'))
        day = int(data.get('day'))
        hour = int(data.get('hour'))
        gender = data.get('gender')
        
        # Calculate Bazi
        bazi_info = calculate_bazi(year, month, day, hour, gender)
        analysis = analyze_bazi(bazi_info)
        
        # 1. 先进行八字计算获取命局上下文 (用于联动紫微)
        report = generate_fortune_report(year, month, day, hour, gender)
        bazi_context = {
            '日元': report['命理分析']['日元'],
            '日主强弱': report['命理分析']['日主强弱'],
            '喜用五行': report['命理分析']['开运建议'].split('【')[1].split('】')[0].replace('喜用五行：', '') # 提取喜用
        }
        # 如果上述解析复杂，简化提取逻辑
        try:
            lucky_suggestions = get_lucky_suggestions(report['命理分析']['五行分布'])
            bazi_context['喜用五行'] = lucky_suggestions['喜用五行']
        except:
            pass

        # 2. 将八字上下文注入紫微斗数分析
        from ziwei_calculator import generate_ziwei_report
        ziwei_report = generate_ziwei_report(year, month, day, hour, gender, bazi_context)
        
        return jsonify({
            'success': True,
            'bazi_info': bazi_info,
            'analysis': analysis,
            'ziwei_report': ziwei_report,
            'report': report
        })
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 400

@app.route('/api/match', methods=['POST'])
def match():
    data = request.json
    try:
        male_info = data.get('male')
        female_info = data.get('female')
        
        from bazi_calculator import match_bazi
        result = match_bazi(male_info, female_info)
        
        return jsonify({
            'success': True,
            **result
        })
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)})

if __name__ == '__main__':
    app.run(debug=True)
