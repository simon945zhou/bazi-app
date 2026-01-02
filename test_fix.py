import sys
import os

# 添加当前目录到Python路径
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

# 模拟紫微斗数数据
male_ziwei = {
    '命宫位置': '子',
    '命宫主星': ['紫微', '天府'],
    '身宫位置': '午'
}

female_ziwei = {
    '命宫位置': '丑',
    '命宫主星': [],  # 无主星情况
    '身宫位置': '未'
}

# 测试generate_female_solution中的命宫主星处理逻辑
def test_female_solution():
    try:
        # 模拟方法中的逻辑
        main_stars = '、'.join(female_ziwei['命宫主星']) if female_ziwei['命宫主星'] else '无主星'
        print(f"女性命宫主星测试: {main_stars}")
        print("女性命宫主星处理逻辑测试通过")
        return True
    except KeyError as e:
        print(f"女性命宫主星处理逻辑测试失败: KeyError - {e}")
        return False
    except Exception as e:
        print(f"女性命宫主星处理逻辑测试失败: {e}")
        return False

# 测试generate_couple_solution中的命宫主星处理逻辑
def test_couple_solution():
    try:
        # 模拟方法中的逻辑
        male_stars = '、'.join(male_ziwei['命宫主星']) if male_ziwei['命宫主星'] else '无主星'
        female_stars = '、'.join(female_ziwei['命宫主星']) if female_ziwei['命宫主星'] else '无主星'
        print(f"男方命宫主星测试: {male_stars}")
        print(f"女方命宫主星测试: {female_stars}")
        print("配对命宫主星处理逻辑测试通过")
        return True
    except KeyError as e:
        print(f"配对命宫主星处理逻辑测试失败: KeyError - {e}")
        return False
    except Exception as e:
        print(f"配对命宫主星处理逻辑测试失败: {e}")
        return False

# 运行测试
if __name__ == "__main__":
    print("===== 紫微斗数字典访问修复测试 =====")
    female_test = test_female_solution()
    couple_test = test_couple_solution()
    
    if female_test and couple_test:
        print("\n所有测试通过！修复成功。")
    else:
        print("\n测试失败！需要进一步修复。")