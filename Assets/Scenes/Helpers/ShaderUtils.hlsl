bool Compare(float a, float b)
{
    const float eps = 0.001;
    return abs(a - b) < eps;
}

bool Compare(float2 a, float2 b)
{
    return Compare(a.x, b.x) && Compare(a.y, b.y);
}
