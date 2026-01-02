from knowledge_base import KnowledgeBase

# 初始化知识库
print("正在初始化知识库...")
kb = KnowledgeBase()

# 检查是否已有内容
if len(kb.get_all_categories()) == 0:
    print("知识库为空，正在添加基础内容...")
    kb.initialize_with_basic_content()
    print("知识库初始化完成！")
else:
    print("知识库已有内容，跳过初始化。")

print(f"当前知识库分类: {kb.get_all_categories()}")